<?php if (!defined('THINK_PATH')) exit(); /*a:1:{s:70:"I:\UPUPW_P7\vhosts\cyadmin.com/application/admin\view\login\index.html";i:1465457531;}*/ ?>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title><?php echo \think\Config::get('sitename'); ?></title>

		<meta name="description" content="User login page" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

		<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" href="<?php echo \think\Config::get('url'); ?>/static/admin/css/bootstrap.css" />
		<link rel="stylesheet" href="<?php echo \think\Config::get('url'); ?>/static/admin/css/font-awesome.css" />

		<!-- text fonts -->
		<link rel="stylesheet" href="<?php echo \think\Config::get('url'); ?>/static/admin/css/ace-fonts.css" />

		<!-- ace styles -->
		<link rel="stylesheet" href="<?php echo \think\Config::get('url'); ?>/static/admin/css/ace.css" />

		<!--[if lte IE 9]>
			<link rel="stylesheet" href="<?php echo \think\Config::get('url'); ?>/static/admin/css/ace-part2.css" />
		<![endif]-->
		<link rel="stylesheet" href="<?php echo \think\Config::get('url'); ?>/static/admin/css/ace-rtl.css" />

		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="<?php echo \think\Config::get('url'); ?>/static/admin/css/ace-ie.css" />
		<![endif]-->

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

		<!--[if lt IE 9]>
		<script src="<?php echo \think\Config::get('url'); ?>/static/admin/js/html5shiv.js"></script>
		<script src="<?php echo \think\Config::get('url'); ?>/static/admin/js/respond.js"></script>
		<![endif]-->
	</head>

	<body class="login-layout">
		<div class="main-container">
			<div class="main-content">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1">
						<div class="login-container">
							<div class="center">
								<h1>
									<span class="white" id="id-text2">用户登录</span>
								</h1>
								<h4 class="blue" id="id-company-text">&copy; <?php echo \think\Config::get('sitename'); ?></h4>
							</div>

							<div class="space-6"></div>

							<div class="position-relative">
								<div id="login-box" class="login-box visible widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header blue lighter bigger">
												<i class="ace-icon fa fa-coffee green"></i>
												用户登录
											</h4>

											<div class="space-6"></div>

											<form action="<?php echo url('login/login'); ?>" method="post">
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" name="username" class="form-control" placeholder="用户名" />
															<i class="ace-icon fa fa-user"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" name="password" class="form-control" placeholder="用户密码" />
															<i class="ace-icon fa fa-lock"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="input-icon input-icon-right">
															<input type="text" name="verify" id="verify" placeholder="验证码" />
															<i style="cursor:pointer;" id="refresh" class="ace-icon fa fa-refresh green pointer" title="看不清楚？点击刷新"></i>
														</span>
														<img style="cursor:pointer;" id="verifyimg" src="<?php echo url('login/verify'); ?>" width="100" height="30" title="看不清楚？点击刷新">
													</label>

													<div class="space"></div>

													<div class="clearfix">
														<label class="inline">
															<input type="checkbox" class="ace" name="remember" />
															<span class="lbl"> 记住我</span>
														</label>

														<button type="submit" class="width-35 pull-right btn btn-sm btn-primary">
															<i class="ace-icon fa fa-key"></i>
															<span class="bigger-110">登录</span>
														</button>
													</div>

													<div class="space-4"></div>
												</fieldset>
											</form>
										</div><!-- /.widget-main -->
									</div><!-- /.widget-body -->
								</div><!-- /.login-box -->
							</div><!-- /.position-relative -->

							<div class="navbar-fixed-top align-right">
								<br />
								&nbsp;
								<a id="btn-login-dark" href="#">Dark</a>
								&nbsp;
								<span class="blue">/</span>
								&nbsp;
								<a id="btn-login-blur" href="#">Blur</a>
								&nbsp;
								<span class="blue">/</span>
								&nbsp;
								<a id="btn-login-light" href="#">Light</a>
								&nbsp; &nbsp; &nbsp;
							</div>
						</div>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.main-content -->
		</div><!-- /.main-container -->

		<!-- basic scripts -->

		<!--[if !IE]> -->
		<script src="<?php echo \think\Config::get('url'); ?>/static/admin/js/jquery.js"></script>

		<!-- <![endif]-->

		<!--[if IE]>
<script src="<?php echo \think\Config::get('url'); ?>/static/admin/js/jquery1x.js"></script>
<![endif]-->
		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='<?php echo \think\Config::get('url'); ?>/static/admin/js/jquery.mobile.custom.js'>"+"<"+"/script>");
		</script>

		<!-- inline scripts related to this page -->
		<script type="text/javascript">
			$(function() {
			 $(document).on('click', '.toolbar a[data-target]', function(e) {
				e.preventDefault();
				var target = $(this).data('target');
				$('.widget-box.visible').removeClass('visible');//hide others
				$(target).addClass('visible');//show target
			 });
			 $('#btn-login-dark').on('click', function(e) {
				$('body').attr('class', 'login-layout');
				$('#id-text2').attr('class', 'white');
				$('#id-company-text').attr('class', 'blue');
				
				e.preventDefault();
			 });
			 $('#btn-login-light').on('click', function(e) {
				$('body').attr('class', 'login-layout light-login');
				$('#id-text2').attr('class', 'grey');
				$('#id-company-text').attr('class', 'blue');
				
				e.preventDefault();
			 });
			 $('#btn-login-blur').on('click', function(e) {
				$('body').attr('class', 'login-layout blur-login');
				$('#id-text2').attr('class', 'white');
				$('#id-company-text').attr('class', 'light-blue');
				
				e.preventDefault();
			 });
			 $("#refresh,#verifyimg").on('click',function(e){
				$("#verifyimg").attr('src','<?php echo \think\Config::get('url'); ?><?php echo url('login/verify'); ?>?'+new Date().getTime());
			 })
			});
		</script>
	</body>
</html>
