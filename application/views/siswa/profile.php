<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>PSB SMP NEGERI 19 BANDUNG</title>
    <link rel="icon" href="<?=base_url()?>/assets/img/logo.png" type="image/png">
    
    <!-- Bootstrap Core CSS -->
    <link href="<?=base_url();?>assets/bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="<?=base_url();?>assets/bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="<?=base_url();?>assets/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="<?=base_url();?>assets/bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
     <!-- DataTables CSS -->
    <link href="<?=base_url();?>assets/bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="<?=base_url();?>assets/bower_components/datatables-responsive/css/dataTables.responsive.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
        #container, #sliders {
            min-width: 310px; 
            max-width: 800px;
            margin: 0 auto;
        }
        #container {
            height: 400px; 
        }
    </style>

</head>

<body>
    <div id="wrapper">
        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                
                <a class="navbar-brand" href="<?=base_url();?>">PSB SMP NEGERI 19 BANDUNG</a>
            </div>
            <!-- /.navbar-header -->
			<ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i> <?php echo $nm_siswa; ?> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="<?=base_url();?>index.php/guru/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form text-center" align="center">
						
                               <img style="border-radius:50px;border:1px solid grey"  width="50%" height="50%" src="<?=base_url();?>assets/img/siswa/<?= $photo ?>"> 
                            </div>
                            <!-- /input-group -->
                        </li>
                       <li class="sidebar-search">
						<center><h4><?php echo $nm_siswa; ?></h4></center>
					   </li>
                          <?= $this->load->view('siswa/menu_groups'); ?>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

        <!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                     <div class="col-lg-12">
						<h1 class="page-header">Edit Profile</h1>
					</div>
                <!-- /.col-lg-12 -->
				</div>
            <!-- /.row -->
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">
                        <!-- panel-heading -->
							<div class="panel-heading">
								Edit profile<i class="fa fa-fw"></i>
							</div>
							<!-- /.panel-heading -->
							 <div class="panel-body">
							<div class="row">
								<div class="col-lg-12">
								
								</div>
							</div>
							 <div class="row">
									<div class="col-lg-6">
										<div class="col-lg-3">
									  <img style="border-radius:50px;border:1px solid grey"  width="80%" height="80%" src="<?=base_url();?>assets/img/siswa/<?= $photo ?>"> 
										</div>
									</div>
							</div>
							<?php echo form_open_multipart('siswa/update_photo'); ?>
							<br/>
								<div class="row">
									<div class="col-lg-6">
										<div class="col-lg-6">
											<input type="file" name="image" id="image" >
										</div>
										<div class="col-lg-6">
										<input type="submit" value="Upload" class="btn btn-primary">
										</div>
									</div>
								</div>
							<br/><br/>
								<input type="hidden" id="nis" name="nis" value="<?= $nis; ?>" class="form-control" required="required" />
							<div class="row">
									<div class="col-lg-7">
										<div class="col-lg-3">
										<label>NIS</label>
										</div>
										<div class="col-lg-6">
										<label><?= $nis; ?></label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-7">
										<div class="col-lg-3">
										<label> Nama Siswa </label>
										</div>
										<div class="col-lg-6">
										<label><?= $nm_siswa; ?></label>
										</div>
									</div>
								</div>
								<br/>
								<div class="row">
									<div class="col-lg-7">
										<div class="col-lg-3">
										<label> Kelas </label>
										</div>
										<div class="col-lg-6">
										<label><?= $kelas; ?> </label>
										</div>
									</div>
								</div>
								<br/>
								<div class="row">
									<div class="col-lg-7">
										<div class="col-lg-3">
										<label> Jenis Kelamin </label>
										</div>
										<div class="col-lg-6">
										<label> <?= $jenis; ?></label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-7">
										<div class="col-lg-3">
										<label> Alamat </label>
										</div>
										<div class="col-lg-6">
										<label> <?= $alamat; ?></label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-7">
										<div class="col-lg-3">
										<label> Tempat lahir </label>
										</div>
										<div class="col-lg-6">
										<label> <?= $tmpt; ?></label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-7">
										<div class="col-lg-3">
										<label > Tanggal lahir </label>
										</div>
										<div class="col-lg-6">
										<label> <?= $tgl; ?></label>
										</div>
									</div>
								</div>
								<br/>
								<div class="modal-footer">
									
								</div>
								<?php echo form_close(); ?>
							</div>                          
						</div>
					</div>
				</div>
			</div>
		</div>
</div>
    <!-- jQuery -->
    <script src="<?=base_url();?>assets/bower_components/jquery/dist/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<?=base_url();?>assets/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="<?=base_url();?>assets/bower_components/metisMenu/dist/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="<?=base_url();?>assets/dist/js/sb-admin-2.js"></script>
	
	 <!-- DataTables JavaScript -->
    <script src="<?=base_url();?>assets/bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
    <script src="<?=base_url();?>assets/bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>
	
	<!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <script src="<?=base_url();?>assets/js/highcharts.js"></script>
    <script src="<?=base_url();?>assets/js/highcharts-3d.js"></script>
    <script src="<?=base_url();?>assets/js/exporting.js"></script>

    <script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
                responsive: true
        });
    });
    </script>

</body>

</html>
