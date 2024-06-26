# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

require_relative '../lib/services/promotion_helper/promotion_destroyer'

# every 1.day, at: '12:00 am' do
#   runner 'Services::Promotion::PromotionDestroyer.destroy_expired_promotions'
# end

every 1.day do
  runner 'Promotion.destroy_expired_promotions', environment: 'development'
end
