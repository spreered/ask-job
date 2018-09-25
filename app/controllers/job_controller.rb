require 'line/bot'
class JobController < ApplicationController
  before_action :verify_header, only: :webhook
  skip_before_action :verify_authenticity_token, raise: false
  def index
  end
  def testaction
    reply_text = ask ("一般行政")
    render plain:  slice_message(reply_text)

  end
  def webhook
    
    reply_text = keyword_reply(received_text)
    # response = client.reply_message(reply_token, message)
    response = reply_to_line(reply_text) if reply_text

    head :ok
    # {"events"=>
    #   [{
    #     "type"=>"message", 
    #     "replyToken"=>"49f33fecfd2a4978b806b7afa5163685", 
    #     "source"=>{
    #       "userId"=>"Ua52b39df3279673c4856ed5f852c81d9", 
    #       "type"=>"user"
    #     },
    #     "timestamp"=>1536052545913, 
    #     "message"=>{
    #       "type"=>"text", 
    #       "id"=>"8521501055275", 
    #       "text"=>"??"
    #   }}],
    #   "job"=>{
    #     "events"=>[{
    #       "type"=>"message", 
    #       "replyToken"=>"49f33fecfd2a4978b806b7afa5163685", 
    #       "source"=>{
    #         "userId"=>"Ua52b39df3279673c4856ed5f852c81d9", 
    #         "type"=>"user"
    #         }, 
    #       "timestamp"=>1536052545913, 
    #       "message"=>{
    #         "type"=>"text", 
    #         "id"=>"8521501055275", 
    #         "text"=>"??"
    #       }
    #     }]
    #   }
    # }
  end

  private
  def line 
    @line ||=Line::Bot::Client.new{ |config|
      config.channel_secret = ENV['CHANNEL_SECRET']
      config.channel_token = ENV['CHANNEL_TOKEN']
    }
  end
  def received_text
    message = params['events'][0]['message']
    message['text'] unless message.nil?
  end

  def keyword_reply(received_text)
    if !received_text.present?
      return
    end
    received_text = to_half received_text 
    if received_text[0..1] == '求:'
      ask received_text[2..-1].strip
    else
      return
    end
  end

  def ask(sysnam)
    jobs = Job.sysnam_like(sysnam)
    if jobs.present?
      str = "有喔有查到喔 ~ \n" + stringifyJobs(jobs)
    else
      "你想要問"+sysnam+"嗎？ 沒這個職系喔"
    end
    
  end

  def reply_to_line(reply_text)
    reply_token = params['events'][0]['replyToken']
    messages = slice_message(reply_text).map{|msg| {type:'text', text: msg}}
    # message_arr.each do |reply_message|
      # message = {
        # type: 'text',
        # text: reply_message
      # }
      # puts "send #{message}"
      # put messages
    line.reply_message(reply_token, messages)
    # end
  end
  def stringifyJobs(jobs)
    str = ''
    str << "資料更新時間: #{jobs.first.announce_date}\n"
    jobs.each do |job|
      str << "[#{job.sysnam}, #{job.rank}] #{job.org_name}/#{job.title}\n #{job.view_url}\n\n;;"
    end
     str
  end
  def to_half(str)
    full = "　！＂＃＄％＆＇（）＊＋，－．／０１２３４５６７８９：；＜＝＞？＠ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ［＼］＾＿｀ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ｛｜｝～"
    half = " !\"\#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~" 
    str.tr(full, half)
  end
  def slice_message(reply_text)
    #slice each message within  2000 words
    sentances = reply_text.split(';;')
    message_arr = []
    i = 0 
    message_arr[0] = ''
    sentances.each do |sentance|
      if (message_arr[i].length + sentance.length) < 2000
        message_arr[i] << sentance
      else
        i += 1
        message_arr[i] = sentance
      end
    end
    message_arr
  end

  def verify_header
    channel_secret = ENV['CHANNEL_SECRET'] # Channel secret string
    http_request_body = request.raw_post # Request body string
    hash = OpenSSL::HMAC::digest(OpenSSL::Digest::SHA256.new, channel_secret, http_request_body)
    signature = Base64.strict_encode64(hash)

    # Compare X-Line-Signature request header string and the signature
    if signature != request.headers["X-Line-Signature"]
      redirect_to root_path
    end
    
  end
end
