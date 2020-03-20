variable "ops_manager_versions" {
  default = {
    2.6 = {
      version = "2.6.22"
      build   = "288"
    }

    2.7 = {
      version = "2.7.12"
      build   = "260"
    }

    2.8 = {
      version = "2.8.2"
      build   = "203"
    }

    2.9 = {
      version = "2.9.0"
      build   = "106"
    }
  }
}

variable "tile_versions" {
  default = {
    2.6 = {
      pas         = "2.6.15"
      mysql       = "2.7.5"
      redis       = "2.2.1"
      rabbitmq    = "1.18.3"
      scs         = "3.0.5"
      metrics     = "1.6.1"
      healthwatch = "1.8.0"
      pcc         = "1.8.0"
      credhub     = "1.3.2"
      scdf        = "1.6.1"
      antivirus   = "2.1.6"
      gateway     = "1.0.2"
      fim         = "2.0.0"
      sso         = "1.11.0"
    }

    2.7 = {
      pas         = "2.7.8"
      mysql       = "2.7.5"
      redis       = "2.2.1"
      rabbitmq    = "1.18.3"
      scs         = "3.0.5"
      metrics     = "1.6.1"
      healthwatch = "1.8.0"
      pcc         = "1.8.0"
      credhub     = "1.3.2"
      scdf        = "1.6.1"
      antivirus   = "2.1.6"
      gateway     = "1.0.2"
      fim         = "2.0.0"
      sso         = "1.11.0"
    }

    2.8 = {
      pas         = "2.8.1"
      mysql       = "2.7.5"
      redis       = "2.2.1"
      rabbitmq    = "1.18.3"
      scs         = "3.0.5"
      metrics     = "1.6.1"
      healthwatch = "1.8.0"
      pcc         = "1.8.0"
      credhub     = "1.3.2"
      scdf        = "1.6.1"
      antivirus   = "2.1.6"
      gateway     = "1.0.2"
      fim         = "2.0.0"
      sso         = "1.11.0"
    }

    2.9 = {
      pas         = "2.9.0-rc.2"
      mysql       = "2.7.5"
      redis       = "2.2.1"
      rabbitmq    = "1.18.3"
      scs         = "3.0.5"
      metrics     = "1.6.1"
      healthwatch = "1.8.0"
      pcc         = "1.8.0"
      credhub     = "1.3.2"
      scdf        = "1.6.1"
      antivirus   = "2.1.6"
      gateway     = "1.0.2"
      fim         = "2.0.0"
      sso         = "1.11.0"
    }
  }
}