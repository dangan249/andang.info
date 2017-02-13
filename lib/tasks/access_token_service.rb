require 'capybara'
require 'capybara/poltergeist'
require 'capybara/dsl'

class AccessTokenService
  include Capybara::DSL

  # TODO: check for expire access token
  def get_token
    oauth = LinkedIn::OAuth2.new
    url = oauth.auth_code_url
    visit url

    form = find('form', class: 'grant-access')
    within form do
      fill_in('session_key-oauth2SAuthorizeForm', with: Rails.configuration.linkedin_email)
      fill_in('session_password-oauth2SAuthorizeForm', with: Rails.configuration.linkedin_password)
    end

    find("input[type=submit]").hover
    find("input[type=submit]").trigger(:click)

    print "fetching code"
    count = 0
    while !page.current_url.include?('code=')
      count += 1
      print "." if count & 50 == 0
    end

    puts
    url = page.current_url
    code = CGI.parse(URI.parse(url).query)['code'].first

    acess_token = oauth.get_access_token(code)
    puts acess_token
  end
end
