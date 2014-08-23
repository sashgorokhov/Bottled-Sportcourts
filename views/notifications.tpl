% rebase("_basicpage", title="Уведомления")
<div class="row">
    <div class="col-md-12" style="margin-top:50px;">
        <h1>Уведомления <span class="badge">{{len(notifications)}}</span></h1>
        % for notification in notifications:
            <div class="bs-example" style="margin-top:20px;">
                % if notification['level']==0:
                    <div class="alert alert-info fade in">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">х</button>
                        <small><p>Информационное уведомление | {{notification['datetime']}}</p></small>
                        <p class="lead">{{notification['text']}}</p>
                    </div>
                % end
                % if notification['level']==1:
                    <div class="alert alert-warning fade in">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">х</button>
                        <small><p>Предупреждение | {{notification['datetime']}}</p></small>
                        <p class="lead">{{notification['text']}}</p>
                    </div>
                % end
                % if notification['level']==2:
                    <div class="alert alert-danger fade in">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">х</button>
                        <small><p>Внимание | {{notification['datetime']}}</p></small>
                        <p class="lead">{{notification['text']}}</p>
                    </div>
                % end
            </div>
        % end
    </div>
</div>