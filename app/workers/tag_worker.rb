class TagWorker
  include Sidekiq::Worker

  def perform(*)
    tag = Tag.create(name: FFaker::Lorem.word + rand(1..100).to_s)
    Article.all.sample.tags << tag
    sleep 5
  end
end
