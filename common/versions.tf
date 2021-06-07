variable "ops_manager_versions" {
  default = {
    "2.7" = {
      version = "2.7.12"
      build   = "260"
    }

    "2.8" = {
      version = "2.8.16"
      build   = "323"
    }

    "2.9" = {
      version = "2.9.18"
      build   = "243"
    }

    "2.10" = {
      version = "2.10.11"
      build   = "222"
    }
  }
}

variable "tile_versions" {
  default = {
    "2.7" = {
      pas          = "2.7.33"
      mysql        = "2.7.5"
      redis        = "2.3.5"
      rabbitmq     = "1.19.6"
      scs          = "3.1.20"
      metrics      = "2.0.6"
      metric_store = "1.5.2"
      healthwatch  = "1.8.4"
      pcc          = "1.8.0"
      credhub      = "1.4.8"
      scdf         = "1.10.3"
      antivirus    = "2.1.6"
      gateway      = "1.0.9"
      fim          = "2.0.0"
      sso          = "1.12.4"
    }

    "2.8" = {
      pas          = "2.8.27"
      mysql        = "2.10.3"
      redis        = "2.3.5"
      rabbitmq     = "1.19.6"
      scs          = "3.1.20"
      metrics      = "2.0.6"
      metric_store = "1.5.2"
      healthwatch  = "1.8.4"
      pcc          = "1.11.1"
      credhub      = "1.4.8"
      scdf         = "1.10.3"
      antivirus    = "2.1.6"
      gateway      = "1.0.9"
      fim          = "2.0.0"
      sso          = "1.12.4"
    }

    "2.9" = {
      pas          = "2.9.21"
      mysql        = "2.10.3"
      redis        = "2.3.5"
      rabbitmq     = "1.19.6"
      scs          = "3.1.20"
      metrics      = "2.0.6"
      metric_store = "1.5.2"
      healthwatch  = "1.8.4"
      pcc          = "1.11.1"
      credhub      = "1.4.8"
      scdf         = "1.10.3"
      antivirus    = "2.1.6"
      gateway      = "1.0.9"
      fim          = "2.0.0"
      sso          = "1.12.4"
    }

    "2.10" = {
      pas          = "2.10.13"
      mysql        = "2.10.3"
      redis        = "2.3.5"
      rabbitmq     = "1.19.6"
      scs          = "3.1.20"
      metrics      = "2.0.6"
      metric_store = "1.5.2"
      healthwatch  = "1.8.4"
      pcc          = "1.11.1"
      credhub      = "1.4.8"
      scdf         = "1.10.3"
      antivirus    = "2.1.6"
      gateway      = "1.0.9"
      fim          = "2.0.0"
      sso          = "1.12.4"
    }
  }
}