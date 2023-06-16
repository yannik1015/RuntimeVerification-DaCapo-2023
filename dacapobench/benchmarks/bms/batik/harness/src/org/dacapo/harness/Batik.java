/*
 * Copyright (c) 2009 The Australian National University.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Apache License v2.0.
 * You may obtain the license at
 * 
 *    http://www.opensource.org/licenses/apache2.0.php
 */
package org.dacapo.harness;

import java.io.File;
import java.lang.reflect.Constructor;

import org.dacapo.harness.Benchmark;
import org.dacapo.parser.Config;

/**
 * date:  $Date: 2009-12-24 11:19:36 +1100 (Thu, 24 Dec 2009) $
 * id: $Id: Batik.java 738 2009-12-24 00:19:36Z steveb-oss $
 */
public class Batik extends Benchmark {

  private String[] args;
  private final Constructor<?> constructor;

  public Batik(Config config, File scratch, File data) throws Exception {
    super(config, scratch, data, false);
    Class<?> clazz = Class.forName("org.apache.batik.apps.rasterizer.Main", true, loader);
    this.method = clazz.getMethod("execute");
    this.constructor = clazz.getConstructor(String[].class);
  }

  @Override
  protected void prepare(String size) throws Exception {
    super.prepare(size);
    args = config.preprocessArgs(size, scratch, data);
  }

  public void iterate(String size) throws Exception {
    Object object = constructor.newInstance((Object) args);
    method.invoke(object);
  }
}
