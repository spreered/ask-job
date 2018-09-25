namespace :dev do
  task updateXmlWeb: :environment do
    base_url = 'https://web3.dgpa.gov.tw/WANT03FRONT/AP/WANTF00003.aspx?GETJOB=Y'
    data = Nokogiri::XML(open( base_url ),nil,"utf-8")
    data = Hash.from_xml(data.to_s)
    Job.destroy_all
    data['ROOT']['ROW'].each do |item|
      # if item['PERSON_KIND'] == "一般人員"
      if not ['約僱人員','駐外人員','代理教師','代課教師','實習老師','聘用人員'].include?(item['PERSON_KIND'])
        puts " #{item['ORG_NAME']} , #{item['PERSON_KIND']} , #{item['RANK']}"
        puts " #{item['TITLE']} , #{item['SYSNAM']} , #{item['NUMBER_OF']}"
        puts " #{item['GENDER_TYPE']} , #{item['WORK_PLACE_TYPE']} , #{item['DATE_FROM']}"
        puts " #{item['DATE_TO']} , #{item['IS_HANDICAP']} , #{item['IS_ORIGINAL']}"
        puts " #{item['IS_LOCAL_ORIGINAL']} , #{item['IS_TRANING']} , #{item['TYPE']}"
        puts " #{item['VITAE_EMAIL']} , #{item['WORK_QUALITY']} , #{item['WORK_ITEM']}"
        puts "view url #{item['VIEW_URL']}"

        # catch
        j_id = item['VIEW_URL'].split('?')[1].split('=')[1]
        puts "jid is #{j_id}"
        # 職等轉換
        cnum_tr = "一二三四五六七八九"
        num_tr ="123456789"
          # 簡任十到十三職等 > 10-13
        item['RANK']=item['RANK'].tr(cnum_tr,num_tr).gsub("十","10").gsub(/10[0-9]/){|s|s[1]='';s}.gsub(/[^0-9]/," ").scan(/\w+/).join('-').gsub(/\-[0-9]\-/,'-') if item['RANK']

        Job.create!(
          j_id: j_id,
          org_name: item['ORG_NAME'], 
          person_kind: item['PERSON_KIND'] ,
          rank: item['RANK'],
          title: item['TITLE'], 
          sysnam: item['SYSNAM'], 
          number_of: item['NUMBER_OF'],
          gender_type: item['GENDER_TYPE'], 
          work_place_type: item['WORK_PLACE_TYPE'], 
          date_from: item['DATE_FROM'],
          date_to: item['DATE_TO'],
          is_handicap: item['IS_HANDICAP'], 
          is_original: item['IS_ORIGINAL'], 
          is_local_original: item['IS_LOCAL_ORIGINAL'], 
          is_traing: item['IS_TRANING'], 
          j_type: item['TYPE'], 
          vitae_email: item['VITAE_EMAIL'], 
          work_quality: item['WORK_QUALITY'], 
          work_item: item['WORK_ITEM'], 
          work_address: item['WORK_ADDRESS'], 
          contact_method: item['CONTACT_METHOD'], 
          url_link: item['URL_LINK'], 
          view_url: item['VIEW_URL'],
          announce_date: data['ROOT']['ANNOUNCE_DATE'] 
        )
      end
    end
  end
end
