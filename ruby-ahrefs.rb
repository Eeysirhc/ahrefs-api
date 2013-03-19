require 'open-uri'
require 'json'

output = File.open('ahrefs_results.csv','w')

header = "Target URL \t Total Backlinks \t Linking Domains \t Unique IPs \t .Com Links \t .Edu Links \t .Gov Links \n"

puts header
output.write header

key = "INSERT_YOUR_API_KEY_HERE"

# Change .TXT to .CSV below if needed
File.open("links.txt").each {|line|
 line = line.gsub("\n","")
 data = line.split("\t")
 target = data.first.strip

backlink_count = "http://api.ahrefs.com/get_backlinks_count.php?target=#{target}&mode=exact&output=json&AhrefsKey=#{key}"
domain_count = "http://api.ahrefs.com/get_ref_domains_ips_count.php?target=#{target}&mode=exact&output=json&AhrefsKey=#{key}"

backlinks_data = open(backlink_count).read
backlinks_results = JSON.parse(backlinks_data)

domain_data = open(domain_count).read
domain_results = JSON.parse(domain_data)

results = "#{target}" + "\t" + backlinks_results["Result"]["Backlinks"].to_s + "\t" + domain_results["Result"]["Domains"].to_s + "\t" + domain_results["Result"]["Ips"].to_s + "\t" + domain_results["Result"]["ClassC"].to_s + "\t" + domain_results["Result"]["Edu"].to_s + "\t" + domain_results["Result"]["Gov"].to_s + "\n"

puts results
output.write results

}

unit_count = "http://api.ahrefs.com/get_units_left.php?output=json&AhrefsKey=#{key}"
units_data = open(unit_count).read
units_results = JSON.parse(units_data)

puts "You have " + units_results["AhrefsApiResponse"]["api_units_left"].to_s + " API calls remaining."