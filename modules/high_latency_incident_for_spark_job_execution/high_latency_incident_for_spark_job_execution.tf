resource "shoreline_notebook" "high_latency_incident_for_spark_job_execution" {
  name       = "high_latency_incident_for_spark_job_execution"
  data       = file("${path.module}/data/high_latency_incident_for_spark_job_execution.json")
  depends_on = [shoreline_action.invoke_spark_task_latency_check,shoreline_action.invoke_optimize_spark_job]
}

resource "shoreline_file" "spark_task_latency_check" {
  name             = "spark_task_latency_check"
  input_file       = "${path.module}/data/spark_task_latency_check.sh"
  md5              = filemd5("${path.module}/data/spark_task_latency_check.sh")
  description      = "Inefficient Code: Inefficient code can cause high latency during Spark job execution. This can happen when a developer writes code that doesn't optimize the use of Spark resources. For example, if a developer writes code that doesn't take advantage of Spark's in-memory processing capabilities, it can cause high latency during Spark job execution."
  destination_path = "/agent/scripts/spark_task_latency_check.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "optimize_spark_job" {
  name             = "optimize_spark_job"
  input_file       = "${path.module}/data/optimize_spark_job.sh"
  md5              = filemd5("${path.module}/data/optimize_spark_job.sh")
  description      = "Optimize the Spark job code and ensure that it is running efficiently without any unnecessary operations that could slow down the execution."
  destination_path = "/agent/scripts/optimize_spark_job.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_spark_task_latency_check" {
  name        = "invoke_spark_task_latency_check"
  description = "Inefficient Code: Inefficient code can cause high latency during Spark job execution. This can happen when a developer writes code that doesn't optimize the use of Spark resources. For example, if a developer writes code that doesn't take advantage of Spark's in-memory processing capabilities, it can cause high latency during Spark job execution."
  command     = "`chmod +x /agent/scripts/spark_task_latency_check.sh && /agent/scripts/spark_task_latency_check.sh`"
  params      = ["LATENCY_THRESHOLD","PATH_TO_LOG_FILE"]
  file_deps   = ["spark_task_latency_check"]
  enabled     = true
  depends_on  = [shoreline_file.spark_task_latency_check]
}

resource "shoreline_action" "invoke_optimize_spark_job" {
  name        = "invoke_optimize_spark_job"
  description = "Optimize the Spark job code and ensure that it is running efficiently without any unnecessary operations that could slow down the execution."
  command     = "`chmod +x /agent/scripts/optimize_spark_job.sh && /agent/scripts/optimize_spark_job.sh`"
  params      = ["JOB_FILE"]
  file_deps   = ["optimize_spark_job"]
  enabled     = true
  depends_on  = [shoreline_file.optimize_spark_job]
}

