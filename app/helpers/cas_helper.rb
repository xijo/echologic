module CasHelper
  def cas_login_token
    base_uri = URI.parse(CASClient::Frameworks::Rails::Filter.config[:cas_base_url])
    use_ssl = (base_uri.scheme == 'https' ? true : false)
    http = Net::HTTP.new(base_uri.host, use_ssl ? 443 : 80)
    http.use_ssl = use_ssl
    req = Net::HTTP::Post.new('/loginTicket')
    return http.request(req).body
  end
end
