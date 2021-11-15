#!/bin/bash
helm package ./atto-app
mv ./atto-app-* charts/
helm repo index charts/ --url https://attopartners.github.io/helmcharts/charts/