[ :lecture, :pz, :lab, :test, :exam, :under, :kp ].each do |type|
  Lesson.find_or_create_by!(lesson_type: type)
end

faculties_data = [
  { full_name: "Строительный факультет", short_name: "СТР", processing_time: "14:00", src: "https://www.bsut.by/university/faculties/sf", password: ENV['STR_PASSWORD'], email: "admin_str@bsut.mail.ru" },
  { full_name: "Факультет экономики и бизнес-технологий:", short_name: "ФЭБТ", processing_time: "14:10", src: "https://www.bsut.by/university/faculties/gef", password: ENV['FEBT_PASSWORD'], email: "admin_febt@bsut.mail.ru" },
  { full_name: "Военно-транспортный факультет", short_name: "ВТФ", processing_time: "14:20", src: "https://www.bsut.by/university/faculties/vtf", password: ENV['VTF_PASSWORD'], email: "admin_vtf@bsut.mail.ru" },
  { full_name: "Электротехнический факультет", short_name: "ЭТФ", processing_time: "14:30", src: "https://www.bsut.by/university/faculties/etf", password: ENV['ETF_PASSWORD'], email: "admin_etf@bsut.mail.ru" },
  { full_name: "Факультет промышленнного и гражданского строительства", short_name: "ПГС", processing_time: "14:40", src: "https://www.bsut.by/university/faculties/pgs", password: ENV['PGS_PASSWORD'], email: "admin_pgs@bsut.mail.ru" },
  { full_name: "Механический факультет", short_name: "МЕХ", processing_time: "14:50", src: "https://www.bsut.by/university/faculties/mf", password: ENV['MEH_PASSWORD'], email: "admin_meh@bsut.mail.ru" },
  { full_name: "Факультет управления процессами пеервозок", short_name: "УПП", processing_time: "15:00", src: "https://www.bsut.by/university/faculties/upp", password: ENV['UPP_PASSWORD'], email: "admin_upp@bsut.mail.ru" }
]
User.delete_all
faculties = faculties_data.map do |faculty|
  facult = Faculty.find_or_create_by!(short_name: faculty[:short_name]) do |f|
    f.full_name = faculty[:full_name]
    f.processing_time = faculty[:processing_time]
    f.src = faculty[:src]
  end

  User.find_or_create_by!(email: faculty[:email]) do |u|
    u.password = faculty[:password]
    u.admin = true
    u.faculty_id = facult.id
  end
end

super_admin = User.find_or_create_by!(email: 'superadmin@bsut.mail.ru') do |u|
  u.password = '7yu7ukmaj3'
  u.super_admin = true
  u.admin = true
end