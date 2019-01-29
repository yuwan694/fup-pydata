init:
	pip install --upgrade pip
	pip install -r requirements.txt

notebooks:
	PYTHONPATH=$${PYTHONPATH}:$$(pwd) jupyter notebook

unit-tests:
	python -m unittest discover -v -stests -p*_test.py

self-tests:
	export PYTHONPATH=$${PYTHONPATH}:$$(pwd); \
	for f in mdkrx/*.py tests/krx_test_queries.py; do \
		echo "> $$f ..."; \
		python $$f; \
		RET=$$?; \
		if [ "$${RET}" != "0" ]; then \
			echo "> Failed on [$$f], return $${RET}, Stop."; \
			exit $${RET}; \
		fi \
	done

install:
	python setup.py install

.PHONY: init notebooks unit-tests self-tests install
