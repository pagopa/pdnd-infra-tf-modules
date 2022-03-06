resource "aws_wafv2_ip_set" "ipset" {
  name               = var.ip_set_name
  description        = var.ip_set_description
  scope              = var.scope 
  ip_address_version = var.ip_set_address_version 
  addresses          = var.ip_set_addresses

  tags = merge({
    Name        = "${var.project_name}-${var.environment}-waf"
    Environment = var.environment
  }, var.tags
  )
}

resource "aws_wafv2_rule_group" "rule_group" {
  capacity = 10
  name     = var.rule_group_name
  scope    = var.scope

  rule {
    name     = "white-list-by-ip"
    priority = 1

    action {
      count {}
    }

    statement {
      ip_set_reference_statement {
            arn = aws_wafv2_ip_set.ipset.arn
          }
    }

    visibility_config {
      cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
      metric_name                = "friendly-rule-metric-name"
      sampled_requests_enabled   = var.sampled_requests_enabled
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled 
    metric_name                = "${var.project_name}-${var.environment}-waf-${var.rule_group_name}-metric"
    sampled_requests_enabled   = var.sampled_requests_enabled 
  }
}

resource "aws_wafv2_web_acl" "web_acl" {
  name  = var.web_acl_name
  scope = var.scope

  default_action {
        block {}
  }


  rule {
    name     = "DefaultAwsManagedRules"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled 
      metric_name                = "${var.project_name}-${var.environment}-waf-rule-metric"
      sampled_requests_enabled   = var.sampled_requests_enabled 
    }
  }
  rule {
    name     = "IPReputationAwsManagedRules"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled 
      metric_name                = "${var.project_name}-${var.environment}-waf-rule-metric"
      sampled_requests_enabled   = var.sampled_requests_enabled 
    }
  }
  rule {
    name     = "SQLAwsManagedRules"
    priority = 3

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled 
      metric_name                = "${var.project_name}-${var.environment}-waf-rule-metric"
      sampled_requests_enabled   = var.sampled_requests_enabled 
    }
  }
  rule {
    name     = "LinuxAwsManagedRules"
    priority = 4

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled 
      metric_name                = "${var.project_name}-${var.environment}-waf-rule-metric"
      sampled_requests_enabled   = var.sampled_requests_enabled 
    }
  }
  rule {
    name     = "BadInputsAwsManagedRules"
    priority = 5

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled 
      metric_name                = "${var.project_name}-${var.environment}-waf-rule-metric"
      sampled_requests_enabled   = var.sampled_requests_enabled 
    }
  }
    
  rule {
    name     = "white-list"
    priority = 100

    override_action {
      count {}
    }

    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.rule_group.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled 
      metric_name                = "${var.project_name}-${var.environment}-waf-rule-metric"
      sampled_requests_enabled   = var.sampled_requests_enabled 
    }
  }

  tags = merge({
    Name        = "${var.project_name}-${var.environment}-waf"
    Environment = var.environment
  }, var.tags
  )

  visibility_config {
    cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled 
    metric_name                = "${var.project_name}-${var.environment}-waf-${var.web_acl_name}-metric"
    sampled_requests_enabled   = var.sampled_requests_enabled 
  }
}

resource "aws_wafv2_web_acl_association" "acl_association" {
  resource_arn = data.aws_lb.origin.arn
  web_acl_arn  = aws_wafv2_web_acl.web_acl.arn
}

data "aws_lb" "origin" {
  name = var.lb_name
}