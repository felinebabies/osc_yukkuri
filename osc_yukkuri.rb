require 'osc-ruby'
require 'osc-ruby/em_server'
require 'dotenv'
require 'date'
require 'shellwords'

Dotenv.load

oscport = ENV['PORT'] || 3333

aquestalk_path = ENV['AQUESTALK_PATH'] || '/home/pi/tool/aquestalkpi/AquesTalkPi'

server = OSC::EMServer.new(oscport)

server.add_method '/jihou' do
    timestr = Time.now.strftime("%Y年%m月%d日%H時%M分")
    system(aquestalk_path, '"現在は、#{timestr}です。" | aplay')
end

server.add_methid '/freetext' do |message|
    arg = "'#{Shellwords.escape(message)}'' | aplay"
    system(aquestalk_path, arg)
end

server.run
