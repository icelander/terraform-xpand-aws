resource "local_file" "setup_script" {
  depends_on = [aws_instance.jumpbox]
  filename = "../deploy/setup.sh"
  file_permission = "0755"
  content = templatefile("./templates/setup.sh.tmpl", {
    bastion_ip = aws_instance.jumpbox.public_ip
    ssh_key_path = var.ssh_key_path
  })
}

resource "local_file" "xpand_script" {
  filename = "../deploy/xpand_setup.sh"
  file_permission = "0755"
  content = templatefile("./templates/xpand_setup.sh.tmpl", {
    db_servers = aws_instance.xpand_db
    maxscale_servers = aws_instance.maxscale
    xpand_archive_filename = var.xpand_archive_filename
    ssh_user = "centos"
  })
}

resource "local_file" "maxscale_script" {
  filename = "../deploy/maxscale_setup.sh"
  file_permission = "0755"
  content = templatefile("./templates/maxscale_setup.sh.tmpl", {
    maxscale_servers = aws_instance.maxscale
    xpand_servers = aws_instance.xpand_db
    db_names = "${join(" ", formatlist("xpand%v", range(var.db_instance_count)))}"
    ssh_user = "centos"
    token = var.mariadb_es_token
  })
}

resource "local_file" "ssh_config" {
  filename = "../deploy/ssh_config"
  content = templatefile("./templates/ssh_config.tmpl", {
    user = "rocky"
    ssh_user = "centos"
    bastion_ip = "${aws_instance.jumpbox.public_ip}"
    db_servers = aws_instance.xpand_db
    maxscale_servers = aws_instance.maxscale
    ssh_key_path = var.ssh_key_path
  })
}

resource "local_file" "xpand_license" {
  filename = "../deploy/sql/xpand.sql"
  content = templatefile("./templates/xpand.sql.tmpl", {
    xpand_license = var.xpand_license
    xpand_root_password = var.xpand_root_password
    maxscale_servers = aws_instance.maxscale
  })
}