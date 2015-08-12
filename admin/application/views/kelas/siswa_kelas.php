<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SMPN 19 Bandung</title>

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

</head>

<body>

    <div id="wrapper">

         <?= $this->load->view('nav'); ?>

        <!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                     <div class="col-lg-12">
                    <h1 class="page-header"> Siswa</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="dataTable_wrapper">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>NIS</th>
                                            <th>Nama siswa</th>
                                            <th>jenis_kelamin</th>
                                            <th>Kelas</th>
                                            
											<th>Operations</th>
                                            
                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                     
                                    <?php
                                    					$i = 1 ;
                                                        foreach ($listsiswakelas->result() as $rows) {
                                                    	?>
                                    										<tr>
                                    											<td><?= $rows->nis?></td>
                                    											<td><?= $rows->name?></td>
																				<td><?= $rows->jenis_kelamin?></td>
                                                                                <td><?= $rows->kelas?></td>
                                                                                
																				<td><!-- Button trigger modal -->
																					<!-- <button class="btn btn-primary " data-toggle="modal" data-target="#myModal<?=$i?>">
																					Update Kelas
																					</button> -->
																					<!-- Modal -->
																					<div class="modal fade" id="myModal<?=$i?>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
																					<div class="modal-dialog">
																					<div class="modal-content">
																					<div class="modal-header">
																					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
																					<h4 class="Form-add-Nilai" id="myModalLabel">Kelas</h4>
																					</div>
																					<div class="modal-body">
																					<?php echo validation_errors(); ?>

																					<?php echo form_open('kelas/updatedata'); ?>
											
																					<div class="form-group">
																					
																					
																					<label>Kelas</label>
																					<select class="form-control" name="id_kelas">

																					<?php
																						 foreach ($combobox_kelas->result() as $rowmenu) {
																								?>
																					<option value="<?= $rowmenu->id_kelas?>" <?php echo set_select('myselect', '$rowmenu->id_kelas'); ?> ><?= $rowmenu->nm_kelas?></option>
																					
																					<?php
																					}
																					?>
																					</select> 
																					</div>
																					
																					
																					 <div class="modal-footer">
																						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
																						<input type="submit" value="Save" class="btn btn-primary">
																					
																					</div>
																					<?php echo form_close(); ?>
																						
																					</div>
                                        
																					<!-- /.modal-content -->
																					</div>
																					</div>
																					</div>
																					</td>
                                                                                
                                                
                                    										</tr>
                                    <?php $i = $i + 1 ; } ?>
									</tbody>   
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                           
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="<?=base_url();?>assets/bower_components/jquery/dist/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<?=base_url();?>assets/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="<?=base_url();?>assets/bower_components/metisMenu/dist/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="<?=base_url();?>assets/dist/js/sb-admin-2.js"></script>
	
	 <!-- DataTables JavaScript -->
    <script src="<?=base_url();?>assets/bower_components/DataTables/media/js/jquery.dataTables.min.js"></script>
    <script src="<?=base_url();?>assets/bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"></script>
	
	<!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
                responsive: true
        });
    });
    </script>

</body>

</html>
