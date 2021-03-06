namespace :db do
  desc 'Fill database with sample data'
  task :populate => :environment do
    Rake::Task['db:reset'].invoke

    20.times do
      Post.create!(:title       => Faker::Lorem.words.join(' '),
                   :raw_content => Faker::Lorem.paragraphs(5).join,
                   :published   => true,
                   :slug        => Faker::Lorem.words(2).join)
    end

    2.times do
      Page.create!(:title       => Faker::Lorem.words.join(' '),
                   :raw_content => Faker::Lorem.paragraphs(5).join,
                   :published   => true,
                   :slug        => Faker::Lorem.words(2).join)
    end

    100.times do
      comment = Commentable.find(rand(22) + 1).comments.new
      comment.update_attributes(:author_name  => Faker::Name.name,
                                :author_email => Faker::Internet.email,
                                :author_url   => Faker::Internet.domain_name,
                                :content      => Faker::Lorem.paragraph)
    end
  end
end
