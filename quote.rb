require 'sinatra'
require 'omniauth/oauth'

enable :sessions

#Here you have to put your own Application ID and Secret
APP_ID = "127620657336562"
APP_SECRET = "e901ff4357dd61ff9ac16c1d8a40bfa3"

use OmniAuth::Builder do
  provider :facebook, APP_ID, APP_SECRET, { :scope => 'email, status_update, publish_stream' }
end

get '/' do
    @quotations = []
    @quotations << {:long_text => 'All can be done if the God touch is there', :author => 'Sri Aurobindo'}
    @quotations << {:long_text => 'Try not to become a man of success but a man of value', :author => 'Albert Einstein'}
    @quotations << {:long_text => 'The more difficulties one has to encounter, within and without, the more significant and the higher in inspiration his life will be.', :author => 'Horace Bushnell'}
    @quotations << {:long_text => 'The power of imagination makes us infinite', :author => 'John Muir'}
    @quotations << {:long_text => 'You miss 100% of the shots you do not take', :author => 'Wayne Gretzky'}
    @quotations << {:long_text => 'Do not follow where the path may lead. Go instead where there is no path and leave a trail.', :author => 'Harold R. McAlindon'}
    @quotations << {:long_text => 'We must become the change we want to see', :author => 'Mahatma Gandhi'}
    @quotations << {:long_text => 'The more I want to get something done, the less I call it work', :author => 'Richard Bach'}
    @quotations << {:long_text => 'Whatever you think that you will be. If you think yourself weak,weak you will be; if you think yourself strong,you will be', :author => 'Vivekananda'}

    erb :index
end

get '/auth/facebook/callback' do
  session['fb_auth'] = request.env['omniauth.auth']
  session['fb_token'] = session['fb_auth']['credentials']['token']
  session['fb_error'] = nil
  redirect '/'
end

get '/auth/failure' do
  clear_session
  session['fb_error'] = 'In order to use this site you must allow us access to your Facebook data<br />'
  redirect '/'
end

get '/logout' do
  clear_session
  redirect '/'
end

def clear_session
  session['fb_auth'] = nil
  session['fb_token'] = nil
  session['fb_error'] = nil
end