
@@channel = EM::Channel.new

get '/chat' do
  stream :keep_open do |s|
    sid = @@channel.subscribe do |msg|
      begin
        s.write msg
        s.flush
        s.close
      rescue
        s.close
      end
      @@channel.unsubscribe sid
    end
    puts "<#{sid}> comet"

    EM::add_timer 60 do
      s.close
      @@channel.unsubscribe sid
    end
  end
end

post '/chat' do
  data = params[:data]
  @@channel.push data
  data
end
