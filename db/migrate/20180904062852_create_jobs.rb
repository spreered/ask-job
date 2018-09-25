class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :j_id, default:""
      t.string :org_name, default:""
      t.string :person_kind, default:""
      t.string :rank, default:""
      t.string :title, default:""
      t.string :sysnam, default:""
      t.string :number_of, default:""
      t.string :gender_type, default:""
      t.string :work_place_type, default:""
      t.string :date_from, default:""
      t.string :date_to, default:""
      t.string :is_handicap, default:""
      t.string :is_original, default:""
      t.string :is_local_original, default:""
      t.string :is_traing, default:""
      t.string :j_type, default:""
      t.string :vitae_email, default:""
      t.string :work_quality, default:""
      t.string :work_item, default:""
      t.string :work_address, default:""
      t.string :contact_method, default:""
      t.string :url_link, default:""
      t.string :view_url, default:""
      t.string :announce_date, default:""
      t.timestamps
    end
  end
end
