class Rack::Attack
  ### Throttle toutes les requêtes par IP, sauf assets ###
  throttle('req/ip', limit: 300, period: 5.minutes) do |req|
    req.ip unless req.path.start_with?('/assets')
  end

  ### Protection brute-force login ###
  LOGIN_PATH = '/users/sign_in'

  throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
    if req.path == LOGIN_PATH && req.post?
      req.ip
    end
  end

  throttle('logins/email', limit: 5, period: 20.seconds) do |req|
    if req.path == LOGIN_PATH && req.post?
      req.params['email'].to_s.downcase.strip.presence
    end
  end

  ### Réponse personnalisée quand quota dépassé ###
  self.throttled_response = lambda do |env|
    retry_after = (env['rack.attack.match_data'] || {})[:period]
    [
      429,
      { 'Content-Type' => 'application/json', 'Retry-After' => retry_after.to_s },
      [{ error: "Trop de requêtes, merci de réessayer plus tard." }.to_json]
    ]
  end
end
