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

        <div class="card profile-card shadow-sm border-0 mt-2 mb-4 me-2">
            <div class="card-body">
                <form action="/SMOFailure" method="post" class="needs-validation" id="mainForm">
                    <div class="row justify-content-center">
                        <div class="col-md-4 mb-4">
                            <div class="mb-3">
                                <label class="form-label d-flex justify-content-center" for="canalsCount">Кол-во каналов</label>
                                <div class="input-group has-validation">
                                    <input type="text" class="form-control" id="canalsCount" name="canalsCount" value={{canalsCount}}></input>
                                    <div class="invalid-feedback"></div>
                                </div>
                            </div>                        
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="mb-3">
                                <label class="form-label d-flex justify-content-center" for="intensityFlowOfRequests">Коэффициент λ</label>
                                <div class="input-group has-validation">
                                    <input type="text" class="form-control" id="intensityFlowOfRequests" name="intensityFlowOfRequests" value={{intensityFlowOfRequests}}></input>
                                    <div class="invalid-feedback"></div>
                                </div>
                            </div>                                                          
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="mb-3">
                                <label class="form-label d-flex justify-content-center" for="requestExecutionMinute">Время обслуживания заявки</label>
                                <div class="input-group has-validation">
                                    <input type="text" class="form-control" id="requestExecutionMinute" name="requestExecutionMinute" value={{requestExecutionMinute}}></input>
                                    <div class="invalid-feedback"></div>
                                </div>
                            </div>                        
                        </div>                
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-md-4 mb-4">
                            <div class="mb-3">
                                <label class="form-label d-flex justify-content-center" for="endTimeMinute">Конечное время</label> 
                                <div class="input-group has-validation">
                                    <input type="text" class="form-control" id="endTimeMinute" name="endTimeMinute" value={{endTimeMinute}}></input>
                                    <div class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="mb-3">
                                <label class="form-label d-flex justify-content-center" for="repeatCount">Кол-во итераций</label>
                                <div class="input-group has-validation">
                                    <input type="text" class="form-control" id="repeatCount" name="repeatCount" value={{repeatCount}}></input>
                                    <div class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                    </div>                
                    <div class="mb-3 mt-4 text-center">
                        <button type="submit" class="btn btn-our-result" id="finish">
                            <i class="fa fa-calculator"></i> Рассчитать
                        </button>
                    </div>
                </form>
                <div class="mb-3">
                <p class="results d-flex justify-content-center">{{result}}</p>
            </div>            
        </div>
    </div>
</div>

<script>
$(document).ready(function(){   
    // Инициализация уже существущих полей в разметке
    $("#mainForm input[type=text]").each(function () {
        initializeHandlersFloat($(this));
    });
    $("#canalsCount").each(function () {
        initializeHandlersInt($(this));
    });
    $("#repeatCount").each(function () {
        initializeHandlersInt($(this));
    });
});
</script>

<script src="/static/scripts/SMO_logic.js"></script>