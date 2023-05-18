% rebase('layout.tpl', title='Home Page', year=year)

<div class="row">    
    <div class="col-md-4 d-none d-md-block">
        <img src="/static/images/SmoCat.png" alt="" class="img-fluid2">
    </div>

    <div class="col-md-8">
        <h3>Системы массового обслуживания</h3>
        <p>Одним из методов исследования сложных систем, в том числе, и систем массового обслуживания (СМО) является метод имитационного моделирования, когда модель (как следует из названия вида моделирования) имитирует работу реальной системы, т.е. модель воспроизводит процесс функционирования реальной системы во времени.</p>
        <p>Любая система, как известно, представляет собой совокупность взаимосвязанных элементов и, следовательно, построение ее адекватной имитационной модели предполагает имитацию процесса функционирования каждого отдельного элемента системы с обязательным сохранением логики и правил взаимодействия и развития составляющих систему элементов, как во времени, так и в пространстве (в том числе последовательность и параллелизм их во времени).</p>     
        <p>λ - интенсивность потока заявок. Зная этот коэффициент мы можем узнать промежуток времени между заявками по формуле: -(1/λ)*ln(r), где r - случайное число. </p>

        <div class="card profile-card shadow-sm border-0 mt-2">
            <div class="card-body">
                <div class="row">                    
                    <div class="col-md-4 mb-2">                        
                        <div class="mb-3">
                            <label class="form-label">Коэффициент λ</label>
                            <input type="number" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Кол-во повторений</label> 
                            <input type="number" class="form-control">
                        </div>                                              
                    </div>
                    <div class="col-md-4 mb-2">
                        <div class="mb-3">
                            <label class="form-label">Кол-во каналов</label>
                            <input type="number" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Интенсивность потока</label> 
                            <input type="number" class="form-control">
                        </div> 
                    </div>
                    <div class="col-md-4 mb-2">
                        <div class="mb-3">
                            <label class="form-label">Время обслуживания</label>
                            <input type="number" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ограничения очереди*</label> 
                            <input type="number" class="form-control">
                            <p>* 0 - неограниченно</p>
                        </div> 
                    </div>
                </div>
            </div>
            <div class="mb-3 text-center">
                <button type="submit" class="btn btn-our-result" id="finish">
                    <i class="fa fa-calculator"></i> Рассчитать
                </button>
            </div>
            <div class="mb-3">
                <p class="results"></p>
            </div>
        </div>
    </div>
</div>