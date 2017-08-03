class Captcha

  def self.is_valid?(ip, params)
    res = Net::HTTP.post_form(
      URI.parse('http://www.google.com/recaptcha/api/verify'),
      {
        'privatekey' => '6Ldt5icUAAAAADMgPkDRpb5S3sZWvDoSH0Va7Dax',
        'remoteip'   => ip,
        'challenge'  => params[:recaptcha_challenge_field],
        'response'   => params[:recaptcha_response_field]
      }
    )

    success, error_key = res.body.lines.map(&:chomp)
    success
  end

end
