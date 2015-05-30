before '/*.json' do
  content_type 'application/json'
end

get '/' do
  haml :index
end
