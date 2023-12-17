@echo off
title L2J4Team geodata converter

java -Xmx512m -cp ./libs/*; net.sf.l2j.geodataconverter.GeoDataConverter

pause
