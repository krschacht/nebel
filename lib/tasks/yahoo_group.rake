require "yahoo_group"

namespace :yahoo_group do
  task :import, [:cookies] => :environment do |task, args|
    args.with_defaults cookies: "RMBX=25q2aj99j79it&b=3&s=k5&t=85; HP=0; B=25q2aj99j79it&b=4&d=so.JLrRpYEIGdq1Tc1PngLdj9_uTbMFKA0sv4w--&s=vm&i=VJnxwh4.9WzAWumgmypF; AO=o=0; YLS=v=1&p=1&n=1; F=a=j5T6K8IMvSta7.51j_gafsp.uByYjq_UGC.sRSxFRxaHyzCJQ_tSDbYu6JJPt81lk6PzaNU-&b=U6dz; Y=v=1&n=8h5loa87j7g11&l=ahi27027j/o&p=m2f1r63053000000&jb=16|26|&r=8h&lg=&intl=us; PH=fn=3kenfg2Pppq4c87EUuE-&i=us; T=z=4zcPTB4HEUTBGq72E5HL4gzNjE2MAY2NzRPTzM2NjAz&a=YAE&sk=DAAA/lw9MVRSv0&ks=EAAOp0QnvBjD7M_8HSZmvU0rg--~E&d=c2wBTVRZeE53RXhNRE00T0RReE1UYzABYQFZQUUBZwFTUElFSkszSERSNEszVjRBTENEQlZDWEFZWQFzY2lkAUZPVjJxa2k4QXZkcHJsZTVjRGtTVkxXblVfWS0BYWMBQUE3WFRXem4Bb2sBWlcwLQF0aXABaWhJdnlCAXNjAXdsAWZzAWowRlNHRWRUUGN6NAF6egE0emNQVEJBN0U-; SSL=v=1&s=CQ.DcXXdDgkSW2mMGTv.K25qs1rKk8rFSCcne.HJPLyBd8rw9T.Ij62uEkUy0QOekc7IEzsQBPFkHGMVLAhJEA--&kv=0; ypcdb=dc3a320582e9dcd3bf1f7d233875226a; U=mt=nd07GJ2MhYin1nLcpFssasgtJsOeOtWB.aqrENNA&ux=b0cPTB&un=8h5loa87j7g11; ywadp1000714451879=2964043671; fpc1000714451879=ZdwKS3qr|YGFqQSONaa|fses1000714451879=|YGFqQSONaa|ZdwKS3qr|fvis1000714451879=|8M701178MT|8M701178MT|8M701178MT|8|8M701178MT|8M701178MT"

    start_of_import = Time.now
    initial_message_count = Message.count

    yahoo_group = YahooGroup.new(args[:cookies])

    yahoo_group.messages do |yahoo_message|
      MessageFactory.new(yahoo_message).message.save!
    end

    puts "#{User.where("created_at > ?", start_of_import).count} users(s) created, #{User.where("updated_at > ?", start_of_import).count} updated (#{User.count} total)"
    puts "#{Message.count - initial_message_count} message(s) created, #{Message.where("updated_at > ?", start_of_import).count} updated (#{Message.count} total)"
  end
end
