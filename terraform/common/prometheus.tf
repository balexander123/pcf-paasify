data "template_file" "prometheus_product_configuration" {
  template = "${chomp(file("${path.module}/templates/prometheus_config.json"))}"
}

resource "null_resource" "setup_prometheus" {
  depends_on = ["null_resource.setup_pas"]

  provisioner "file" {
    source      = "${path.module}/scripts/install_prometheus_dev.sh"
    destination = "/home/ubuntu/install_prometheus_dev.sh"
  }

  provisioner "remote-exec" {
    inline = ["chmod +x /home/ubuntu/install_prometheus_dev.sh && /home/ubuntu/install_prometheus_dev.sh ${var.opsman_user} ${local.opsman_password}"]
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/setup_tile.sh"

    environment {
      OM_DOMAIN       = "${var.opsman_host}"
      OM_USERNAME     = "${var.opsman_user}"
      OM_PASSWORD     = "${local.opsman_password}"

      PRODUCT_NAME    = "prometheus-dev"
      PRODUCT_CONFIG  = "${data.template_file.prometheus_product_configuration.rendered}"
      AZ_CONFIG       = "${data.template_file.tile_az_configuration.rendered}"
      RESOURCE_CONFIG = "${var.prometheus_resource_configuration}"
    }
  }

  count = "${contains(var.tiles, "prometheus") ? 1 : 0}"

  connection {
    host        = "${var.opsman_host}"
    user        = "ubuntu"
    private_key = "${var.opsman_ssh_key}"
  }
}
