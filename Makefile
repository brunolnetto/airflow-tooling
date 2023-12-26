# Makefile for Apache Airflow Commands

.PHONY: install-dependencies init-web-server start-scheduler run-dag list-dags list-dag-runs backfill-dag \
        pause-dag unpause-dag list-task-instances test-task render-task display-dag-structure \
        airflow-config-list list-plugins airflow-version

install-dependencies:
	python3 -m pip install --upgrade pip
	pip install --quiet apache-airflow
	pip install --quiet apache-airflow[cncf.kubernetes]
	pip install --quiet connexion[swagger-ui]
	pip install --quiet apache-airflow-providers-apache-spark

init-web-server:
	airflow db init

start-web-server:
	airflow webserver --port $(port)

start-scheduler:
	airflow scheduler

create-airflow-user:
	airflow users create \
		--role $(role) \
		--username $(username) \
		--email $(email) \
		--firstname $(firstname) \
		--lastname $(lastname) \
		--password $(password)

run-dag:
	airflow dags trigger -r $(DAG_ID)

list-dags:
	airflow list_dags

list-dag-runs:
	airflow dag_runs list $(DAG_ID)

backfill-dag:
	airflow dags trigger -r $(DAG_ID)

pause-dag:
	airflow dags pause $(DAG_ID)

unpause-dag:
	airflow dags unpause $(DAG_ID)

list-task-instances:
	airflow tasks list $(DAG_ID)

test-task:
	airflow tasks test $(DAG_ID) $(TASK_ID) $(EXECUTION_DATE)

render-task:
	airflow tasks render $(DAG_ID) $(TASK_ID) $(EXECUTION_DATE)

display-dag-structure:
	airflow dags show $(DAG_ID)

airflow-config-list:
	airflow config list

list-plugins:
	airflow plugins list

airflow-version:
	airflow version