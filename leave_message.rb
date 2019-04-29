#!/usr/bin/env ruby

# Sends automated sms like "not feeling well/gonna work from home" etc. Adds a random "reason" from predefined array of strings.

# You need these environment variables:
# Create .env file and place your credential as below
# TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# TWILIO_AUTH_TOKEN=yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy

# Exit early if sessions with my username are found
# exit if `who -q`.include? ENV['USER']

# Install dotenv gem if not present
system("if ! gem list dotenv -i; then gem install dotenv; fi")
# Install twilio-ruby gem if not present
system("if ! gem list twilio-ruby -i; then gem install twilio-ruby; fi")

require 'dotenv'
require 'twilio-ruby'

Dotenv.load

TWILIO_ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID']
TWILIO_AUTH_TOKEN  = ENV['TWILIO_AUTH_TOKEN']

@twilio = Twilio::REST::Client.new TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN

# Phone numbers
my_number      = '+ xx xxx-xxxxxxx'
number_of_boss = '+ xx xxx-xxxxxxx'

excuse = [
  'Locked out',
  'Family Problem',
  'Food poisoning',
  'Not feeling well'
].sample

# Send a text message
@twilio.messages.create(
  from: my_number, to: number_of_boss,
  body: "Gonna work from home. #{excuse}"
)

# Log this
puts "Message sent at: #{Time.now} | Excuse: #{excuse}"