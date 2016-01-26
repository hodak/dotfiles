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

  def self.inline!
    require "sidekiq/testing"
    Sidekiq::Testing.inline!
  end
end

# execute sql in rails console
def sql(query)
  ActiveRecord::Base.connection.execute(query)
end

def toggle_show_sql
  current_logger = ActiveRecord::Base.logger
  ActiveRecord::Base.logger = if current_logger then nil else Logger.new(STDOUT) end
end

class Regexp
  def to_javascript
    Regexp.new(inspect.sub('\\A','^').sub('\\Z','$').sub('\\z','$').sub(/^\//,'').sub(/\/[a-z]*$/,'').gsub(/\(\?#.+\)/, '').gsub(/\(\?-\w+:/,'('), self.options).inspect
  end
end

self.send(:include, Rails::ConsoleMethods) if defined? Rails::ConsoleMethods
