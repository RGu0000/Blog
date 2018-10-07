class TagErrorWorker
  include Sidekiq::Worker

  def perform(*)
    number = rand(1..6)
    logger.info("Drawn number #{number}.")
    raise 'number is too high!' if number == 6
  end
end
