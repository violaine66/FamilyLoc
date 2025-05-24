# test_cron.rb
File.open("cron_test_output.txt", "a") do |f|
  f.puts "[#{Time.now}] Cron job executed"
end
