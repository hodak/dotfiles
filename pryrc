def rr!
  Rake.application.instance_variable_get(:@tasks).clear
  load "Rakefile"
end

module Sidekiq
  def self.run!(queue = "default")
    if json = Sidekiq.redis { |r| r.rpop "queue:#{queue}" }
      data = JSON.load(json)
      puts "Running #{data["class"]}"
      data["class"].constantize.new.perform(*data["args"])
    end
  end
end
