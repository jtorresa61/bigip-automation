resource "bigip_ltm_pool" "mypool" {
  name                = "/Common/test-pool"
  allow_nat           = "yes"
  allow_snat          = "yes"
  load_balancing_mode = "round-robin"
}
resource "bigip_ltm_policy" "test-policy" {
  name     = "/Common/test-policy"
  strategy = "first-match"
  requires = ["http"]
  controls = ["forwarding"]
  rule {
    name = "rule6"
    action {
      forward    = true
      connection = false
      pool       = bigip_ltm_pool.mypool.name
    }
  }
  depends_on = [bigip_ltm_pool.mypool]
}