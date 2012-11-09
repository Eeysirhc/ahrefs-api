require 'open-uri'
require 'json'

puts "Target URL" "\t" "Total Backlinks" "\t" "Linking Domains" "\t" "Unique IPs" "\t" ".Com Links" "\t" ".Edu Links" "\t" ".Gov Links" "\t" "Units Left" "\n"

File.open("links.txt").each {|line|
 line = line.gsub("\n","")
 data = line.split("\t")
 target = data.first.strip

key = "INSERT_YOUR_API_KEY_HERE"
backlink_count = "http://api.ahrefs.com/get_backlinks_count.php?target=#{target}&mode=exact&output=json&AhrefsKey=#{key}"
domain_count = "http://api.ahrefs.com/get_ref_domains_ips_count.php?target=#{target}&mode=exact&output=json&AhrefsKey=#{key}"
unit_count = "http://api.ahrefs.com/get_units_left.php?output=json&AhrefsKey=#{key}"

backlinks_data = open(backlink_count).read
backlinks_results = JSON.parse(backlinks_data)

domain_data = open(domain_count).read
domain_results = JSON.parse(domain_data)

units_data = open(unit_count).read
units_results = JSON.parse(units_data)

puts "#{target}" + "\t" + backlinks_results["Result"]["Backlinks"].to_s + "\t" + domain_results["Result"]["Domains"].to_s + "\t" + domain_results["Result"]["Ips"].to_s + "\t" + domain_results["Result"]["ClassC"].to_s + "\t" + domain_results["Result"]["Edu"].to_s + "\t" + domain_results["Result"]["Gov"].to_s + "\t" + units_results["apiresponse"]["api_units_left"].to_s + "\n"

}