% rebase('layout.tpl', title=title, year=year)

<h3 class="text-center">Давайте знакомиться!</h3>

<div class="row d-lg-flex align-items-center">
	<div class="col-lg-3 mt-4">
		<div class="card profile-card shadow-sm border-0" id="firstCard">
			<div class="card-body d-flex justify-content-start d-lg-block align-items-center">
				<img src="/static/images/tema.png" alt="" class="img-fluid profile-card-image mx-auto d-block">

				<div class="d-block">
					<div class="d-lg-block text-lg-center">
						<span class="d-lg-block h6">Платонов</span>
						<span class="d-lg-block">Артем</span>
						<span class="d-lg-block">Игоревич</span>
					</div>
					
					<p class="mt-2">Это наш главный разработчик, программист и верстальщик. Он выполняет самую трудную и монотонную работу. Принимал участие в разработке страницы "Оценка надежности систем".</p>
				</div>
				
				<div class="text-center">
					<button class="btn btn-outline-secondary m-2"><i class="fa fs-14 fa-github"></i> GitHub</button>
				</div>
			</div>
		</div>
	</div>
	<div class="col-lg-6">
		<img src="/static/images/cat2.png" id="dividerImage" class="img-fluid mx-auto d-block d-none d-lg-block mt-4" alt="">
	</div>
	<div class="col-lg-3 mt-4">
		<div class="card profile-card shadow-sm border-0" id="secondCard">
			<div class="card-body d-flex justify-content-start d-lg-block align-items-center">
				<img src="/static/images/Pisha.png" alt="" class="img-fluid profile-card-image mx-auto d-block">

				<div class="d-block">
					<div class="d-lg-block text-lg-center">
						<span class="d-lg-block h6">Покровский</span>
						<span class="d-lg-block">Михаил</span>
						<span class="d-lg-block">Олегович</span>
					</div>
					
					<p class="mt-2">Наш организатор и тимлид. Он принимает самые важные решения в проекте. Ему можно задать любой вопрос. Принимал участие в разработке страницы "Расчет СМО".</p>
				</div>
				
				<div class="text-center">
					<button class="btn btn-outline-secondary m-2"><i class="fa fa-github"></i> GitHub</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-lg-5 offset-lg-1 mt-4">
		<div class="card profile-card shadow-sm border-0" id="firstCard">
			<div class="card-body d-flex justify-content-start align-items-center">
				<img src="/static/images/matwey.png" alt="" class="img-fluid profile-card-image d-block">

				<div class="d-flex justify-content-start align-items-center d-lg-block">
					<div class="d-block">
						<div>
							<span class="h6">Бельдий</span>
							<span>Матвей</span>
							<span>Олегович</span>
						</div>
						
						<p class="mt-2">Наш документовед и спонсор проекта. Без него и его денег ничего бы не получилось. Принимал участие в разработке страницы "Расчет СМО".</p>
					</div>
					
					<button class="btn btn-outline-secondary m-2"><i class="fa fa-github"></i> GitHub</button>
				</div>
			</div>
		</div>
	</div>
	<div class="col-lg-5 mt-4">
		<div class="card profile-card shadow-sm border-0" id="firstCard">
			<div class="card-body d-flex justify-content-start align-items-center">
				<img src="/static/images/kate.png" alt="" class="img-fluid profile-card-image d-block">

				<div class="d-flex justify-content-start align-items-center d-lg-block">
					<div class="d-block">
						<div>
							<span class="h6">Скобель</span>
							<span>Екатерина</span>
							<span>Владимировна</span>
						</div>
						
						<p class="mt-2">А это я, пишу текст, который никто не будет читать. А также занимаюсь дизайном. Принимала участие в разработке страницы "Оценка надежности систем".</p>
					</div>
					
					<button class="btn btn-outline-secondary m-2"><i class="fa fa-github"></i> GitHub</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		// var height1 = Math.max($("#secondCard").height(), $("#firstCard").height())
		// console.log(height1);
		// $("#firstCard").height(height1)
		// $("#secondCard").height(height1)
		// $("#dividerImage").height(height1)
	});	
</script>