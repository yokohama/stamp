10.times.each do |i|
  User.seed do |obj|
    obj.name = "ユーザー#{i}"
    obj.email = "yuhei.yokohama+#{i}@gmail.com"
    obj.password = 'hogehoge'
    obj.password_confirmation = 'hogehoge'
    obj.skip_confirmation!
  end
end
