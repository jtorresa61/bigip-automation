resource "bigip_ssl_certificate" "app1crt" {
  name      = "app1.crt"
  content   = file("app1.crt")
  partition = "Common"
}

resource "bigip_ssl_key" "app1key" {
  name      = "app1.key"
  content   = file("app1.key")
  partition = "Common"
}

resource "bigip_fast_https_app" "this" {
  application               = "myApp1"
  tenant                    = "ltm_scenario1"
  virtual_server            {
    ip                        = "10.1.10.224"
    port                      = 443
  }
  tls_server_profile {
    tls_cert_name             = "/Common/app1.crt"
    tls_key_name              = "/Common/app1.key"
  }
  pool_members  {
    addresses                 = ["10.1.10.120", "10.1.10.121", "10.1.10.122"]
    port                      = 80
  }
  snat_pool_address = ["10.1.10.50", "10.1.10.51", "10.1.10.52"]
  load_balancing_mode       = "least-connections-member"
  monitor       {
    send_string               = "GET / HTTP/1.1\\r\\nHost: example.com\\r\\nConnection: Close\\r\\n\\r\\n"
    response                  = "200 OK"
  }
  depends_on		      = [bigip_ssl_certificate.app1crt, bigip_ssl_key.app1key]
}