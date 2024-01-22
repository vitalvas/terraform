locals {
  backup_rules = {
    "daily" : {
      schedule          = "cron(0 2 ? * * *)" // Runs every day at 2am UTC
      completion_window = 180
      start_window      = 60

      lifecycle = {
        delete_after = 30
      }
    },
    "weekly" : {
      schedule          = "cron(0 6 ? * SUN *)" // Runs every Sunday at 6am UTC
      completion_window = 180
      start_window      = 60

      lifecycle = {
        cold_storage_after = 8
        delete_after       = 180
      }
    },
  }
}
