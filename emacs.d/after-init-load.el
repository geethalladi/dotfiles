(defun self/-reload-scratch-buffer ()
  "reload scratch buffer for modes to take effect"
  (let* ((buffer-name "*scratch*")
         (filter-scratch-p (lambda (buf) (string-prefix-p buffer-name (buffer-name buf))))
         (scratch-buffer
          (elt (seq-filter filter-scratch-p (buffer-list)) 0)))
    (with-current-buffer scratch-buffer
      (lisp-interaction-mode)
      ;; Use org mode for scratch
      ;; (org-mode)
      )))

(defun self/load-all ()
  "Load the entire environment"
  (interactive)
  ;; load details about the installed packages
  (self/load-packages)
  (self/use-packages)
  ;; load customizations of these packages
  (self/load-customizations)
  ;; load the development environment
  (self/load-basic-dev-env)
  (self/load-dev-env)
  ;; load org mode customizations
  (self/load-org-env)
  ;; load writing texts
  (self/load-text-customizations)
  ;; load my own lisp extensions
  (self/load-self-lisp)
  ;; clean up modal line
  (self/-diminish-modal-line)
  ;; reload scratch-buffer after loading everything
  (self/-reload-scratch-buffer))

(defun self/load-customizations ()
  "Customize the installed packages"

  ;; emacs getting the same path when invoked from GUI
  ;; (when (memq window-system '(mac ns))
  ;;   (exec-path-from-shell-initialize))

  (setq initial-major-mode 'org-mode)

  ;; ENABLE PERSISTENT SCRATCH
  (require 'persistent-scratch)
  (persistent-scratch-setup-default)
  ;; (persistent-scratch-autosave-mode 1)

  (load (expand-file-name "helm-init.el" user-emacs-directory))
  (load (expand-file-name "keychord-init.el" user-emacs-directory))
  (load (expand-file-name "vendor/help-fns+.el" user-emacs-directory))
  (load (expand-file-name "vendor/tiddlywiki-mode.el" user-emacs-directory))

  (load (expand-file-name "clipboard.el" user-emacs-directory))

  (load (expand-file-name "tramp-init.el" user-emacs-directory))
  (load (expand-file-name "yas-init.el" user-emacs-directory))
  (load (expand-file-name "tex-init.el" user-emacs-directory))
  (load (expand-file-name "pdf-init.el" user-emacs-directory))
  (load (expand-file-name "epub-init.el" user-emacs-directory))

  (load (expand-file-name "custom.el" user-emacs-directory))
  (load (expand-file-name "terminal-key-decode.el" user-emacs-directory))
  (load (expand-file-name "theme-init.el" user-emacs-directory))
  (load (expand-file-name "tamil-font.el" user-emacs-directory))

  ;; Loading font ligatures for development
  (load (expand-file-name "font-ligatures.el" user-emacs-directory)))

(defun self/-diminish-modal-line ()
  "Remove the most used packages from the modal line"

  (require 'diminish)
  ;; Hide from appearing as sub-modes
  (diminish 'google-this-mode)
  (diminish 'helm-mode)
  (diminish 'projectile-mode)
  (diminish 'flyspell-mode)
  (diminish 'smartparens-mode)
  (diminish 'highlight-indentation-mode)
  (diminish 'osx-clipboard-mode)
  (diminish 'editorconfig-mode))

(defun self/use-packages()
  "Load the needed packages"
  (use-package package-build)
  (use-package key-chord)
  (use-package osx-clipboard)
  (use-package yasnippet)
  (use-package yasnippet-snippets)
  (use-package pdf-tools)
  (use-package nov) ;; for epub
  (use-package dash)
  (use-package multiple-cursors)
  (use-package smartparens)
  (use-package exec-path-from-shell)
  (use-package all-the-icons)
  (use-package neotree)
  (use-package ov) ;; overhead highlighting
  (use-package rg)
  (use-package racket-mode)
  (use-package rainbow-delimiters)
  (use-package rainbow-identifiers)
  (use-package rainbow-mode)

  (use-package helm
    :config
    (helm-mode 1))
  (use-package helm-ag)
  (use-package helm-projectile)
  (use-package hydra)

  (use-package google-this)

  (use-package projectile)
  (use-package projectile-rails)

  (use-package git)
  (use-package git-gutter)
  (use-package magit)
  (use-package magit-section)
  (use-package git-gutter-fringe)

  (use-package visual-fill-column)
  (use-package toggle-quotes)

  (use-package company)
  (use-package company-irony)
  (use-package company-jedi)
  (use-package company-terraform)
  (use-package company-restclient)
  (use-package company-wordfreq)

  (use-package flycheck)
  (use-package flycheck-cask)
  (use-package flycheck-clj-kondo)
  (use-package flycheck-haskell)
  (use-package flycheck-hdevtools)
  (use-package flymake-easy)
  (use-package flymake-go)
  (use-package flymake-json)

  (use-package geiser)
  (use-package geiser-chez)
  (use-package geiser-racket)

  (use-package jest)
  (use-package js-doc)
  (use-package js2-mode)
  (use-package js2-refactor)
  (use-package json-mode)
  (use-package json-process-client)
  (use-package mocha)

  ;; TODO Find out what are the use of these packages
  (use-package shut-up)
  (use-package epl)
  (use-package commander)
  (use-package ac-haskell-process)
  (use-package ac-js2)
  (use-package ac-slime)
  (use-package adaptive-wrap)
  (use-package ag)
  (use-package alchemist)
  (use-package anaconda-mode)
  (use-package auto-complete)
  (use-package bats-mode)
  (use-package better-defaults)
  (use-package bind-key)
  (use-package calfw)
  ;; (use-package cask)
  (use-package centaur-tabs)
  (use-package cider)
  (use-package clipetty)
  (use-package color-identifiers-mode)
  (use-package color-theme-buffer-local)
  (use-package command-log-mode)
  (use-package consult)
  (use-package copy-as-format)
  (use-package csv-mode)
  (use-package define-word)
  (use-package diminish)
  (use-package discover)
  (use-package discover-js2-refactor)
  (use-package drag-stuff)
  (use-package ebuku)
  (use-package edit-indirect)
  (use-package editorconfig)
  (use-package ediprolog)
  (use-package efire)
  (use-package ein)
  (use-package el-mock)
  (use-package elisp-slime-nav)
  (use-package emacsql)
  (use-package emacsql-sqlite)
  (use-package emmet-mode)
  (use-package enclose)
  (use-package epl)
  (use-package ereader)
  (use-package erlang)
  ;; (use-package ert-runner)
  (use-package es-mode)
  (use-package expand-region)
  (use-package f)
  (use-package feature-mode)
  (use-package forge)
  (use-package findr)
  (use-package floobits)
  (use-package fringe-helper)
  (use-package fuzzy)
  (use-package github-modern-theme)
  (use-package go-autocomplete)
  (use-package go-mode)
  (use-package graphviz-dot-mode)
  (use-package green-phosphor-theme)
  (use-package grizzl)
  (use-package groovy-mode)
  (use-package hasklig-mode)

  (use-package hi2)
  (use-package highlight)
  (use-package highlight-indentation)
  (use-package highlight-parentheses)
  (use-package hl-anything)
  (use-package htmlize)
  (use-package hungry-delete)
  (use-package hy-mode)
  (use-package idle-highlight-mode)
  (use-package indium)
  (use-package indent-tools)
  (use-package inf-clojure)
  (use-package inflections)
  (use-package javap-mode)
  (use-package jump)
  (use-package less-css-mode)
  (use-package leuven-theme)
  (use-package litable)
  (use-package log4j-mode)
  (use-package logview)
  (use-package lsp-java)
  (use-package lua-mode)
  (use-package marginalia)
  (use-package makey)
  (use-package markdown-mode)
  (use-package maxframe)
  (use-package mew)
  (use-package multi-term)
  (use-package nvm)
  (use-package nginx-mode)
  (use-package noctilux-theme)
  (use-package nodejs-repl)
  (use-package nyan-mode)
  (use-package ob-mermaid)
  (use-package org)
  (use-package org-bullets)
  (use-package org-mime)
  (use-package org-mind-map)
  (use-package org-noter)

  ;; TODO: migrate to org-v2 later
  ;; Using straight.el to install org-roam package
  ;; (depends-on "org-roam" "20210308.457")
  (use-package origami)
  (use-package ox-jira)
  (use-package ox-pandoc)
  (use-package ox-reveal)
  (use-package ox-slack)
  (use-package org-re-reveal)
  (use-package package-build)
  (use-package paredit)
  (use-package paxedit)
  (use-package pipenv)
  (use-package pkg-info)
  (use-package plantuml-mode)
  (use-package pocket-reader)
  (use-package popup)
  (use-package popwin)
  (use-package powerline)
  (use-package pretty-symbols)
  (use-package prodigy)
  (use-package project-explorer)
  (use-package psc-ide)
  (use-package purescript-mode)
  (use-package py-autopep8)
  (use-package quack)
  (use-package quelpa)
  (use-package recentf-ext)
  (use-package restclient)
  (use-package s)
  (use-package scratch)
  (use-package scheme-complete)
  (use-package scribble-mode)
  (use-package shm)
  (use-package sicp)
  (use-package simple-httpd)
  (use-package skewer-mode)
  (use-package slime)
  (use-package smart-mode-line)
  (use-package smex)
  (use-package sr-speedbar)
  (use-package sql-indent)
  (use-package sr-speedbar)
  (use-package stripe-buffer)
  (use-package tabbar)
  (use-package tango-plus-theme)
  (use-package tern)
  (use-package tern-auto-complete)
  (use-package tern-context-coloring)
  (use-package terraform-mode)
  (use-package terraform-doc)
  (use-package tide)
  (use-package tuareg)

  (use-package vlf)
  (use-package wc-mode)
  (use-package web-mode)
  (use-package which-key)
  (use-package wrap-region)
  (use-package writegood-mode)
  (use-package xkcd)
  (use-package xref-js2)
  (use-package yaml-mode)
  (use-package yard-mode)
  (use-package yafolding)
  (use-package yequake)
  (use-package zeal-at-point)

  (use-package vagrant)
  (use-package vagrant-tramp)

  ;; TODO: Unavailable packages
  ;; (use-package org-plus-contrib)
  ;; (use-package pallet)
  ;; (use-package auctex)
  ;; (use-package straight)
  ;; (use-package dash-functional)
  )

(defun self/load-packages ()
  "Loads all the installed packages"
  (require 'use-package)
  ;; Load vendor el files
  (add-to-list 'load-path (expand-file-name "vendor" user-emacs-directory)))

(defun self/load-org-env ()
  "Load the org environment"

  (load (expand-file-name "org-mode-init.el" user-emacs-directory))
  (load (expand-file-name "org-agenda-init.el" user-emacs-directory))
  (load (expand-file-name "org-capture-init.el" user-emacs-directory))
  (load (expand-file-name "org-babel-init.el" user-emacs-directory))
  (load (expand-file-name "vendor/org-colored-text.el" user-emacs-directory)))

(defun self/load-text-customizations ()
  "Load the development environment"
  (load (expand-file-name "text-mode-init.el" user-emacs-directory)))

(defun self/load-basic-dev-env ()
  "Load the basic development environment"
  (load (expand-file-name "smartparens-init.el" user-emacs-directory))

  ;; (load (expand-file-name "term-init.el" user-emacs-directory))
  (load (expand-file-name "multi-term-init.el" user-emacs-directory))
  (load (expand-file-name "eshell-init.el" user-emacs-directory))
  (load (expand-file-name "docker-init.el" user-emacs-directory))

  (load (expand-file-name "company-init.el" user-emacs-directory))
  (load (expand-file-name "projectile-init.el" user-emacs-directory))

  (load (expand-file-name "lisp-init.el" user-emacs-directory))

  (load (expand-file-name "other-modes-init.el" user-emacs-directory)))

(defun self/load-dev-env ()
  "Load the development environment"
  (load (expand-file-name "py-init.el" user-emacs-directory))
  (load (expand-file-name "rb-init.el" user-emacs-directory))
  ;; (load (expand-file-name "haskell-init.el" user-emacs-directory))
  ;; (load (expand-file-name "ocaml-init.el" user-emacs-directory))
  ;; (load (expand-file-name "erlang-init.el" user-emacs-directory))
  ;; (load (expand-file-name "prolog-init.el" user-emacs-directory))

  ;; Loading js init script
  (load (expand-file-name "js-init.el" user-emacs-directory))
  ;; (load (expand-file-name "ts-init.el" user-emacs-directory))
  (load (expand-file-name "web-init.el" user-emacs-directory))

  ;; (load (expand-file-name "elixir-init.el" user-emacs-directory))
  ;; (load (expand-file-name "scala-init.el" user-emacs-directory))
  ;; (load (expand-file-name "go-init.el" user-emacs-directory))
  (load (expand-file-name "c-init.el" user-emacs-directory))

  ;; (load (expand-file-name "java-init.el" user-emacs-directory))
  (load (expand-file-name "clojure-init.el" user-emacs-directory))
  (load (expand-file-name "log-init.el" user-emacs-directory))

  ;; TLA+ specification mode
  (load-file
   (expand-file-name "vendor/tla-pcal-mode.el" user-emacs-directory))

  (self/other-dev-modes)
  (self/load-zeal))

(defun self/other-dev-modes ()
  "Other development modes"
  (require 'terraform-mode)
  (require 'terraform-doc)
  (require 'lua-mode)
  (setq lua-indent-level 1))

(defun self/load-zeal ()
  "Load Zeal Integration"
  (require 'zeal-at-point)
  (global-set-key (kbd "C-c C-d") 'zeal-at-point)

  (add-to-list 'zeal-at-point-mode-alist
         '(python-mode . ("python3" "scipy" "numpy" "pandas" "sqlalchemy")))
  (add-to-list 'zeal-at-point-mode-alist
         '(ruby-mode . ("ruby" "rails")))
  (add-to-list 'zeal-at-point-mode-alist '(emacs-lisp-mode   . ("elisp")))
  (add-to-list 'zeal-at-point-mode-alist '(shell-script-mode . ("bash")))
  (add-to-list 'zeal-at-point-mode-alist '(ocaml-mode        . ("ocaml")))
  (add-to-list 'zeal-at-point-mode-alist '(sql-mode          . ("sqlite" "mysql")))
  (add-to-list 'zeal-at-point-mode-alist '(dockerfile-mode   . ("docker")))
  (add-to-list 'zeal-at-point-mode-alist '(latex-mode        . ("latex"))))

(defun self/load-self-lisp ()
  "Load my personal lisp extensions"

  ;; to facilitate the velocity of lectures
  (load (expand-file-name "self-lisp/lecture-stats.el" user-emacs-directory))
  (load (expand-file-name "self-lisp/index.el" user-emacs-directory))
  ;; for git bookmarks
  (load (expand-file-name "self-lisp/git-bookmarks.el" user-emacs-directory))
  ;; dayjob customizations
  (load (expand-file-name "self-lisp/dayjob.el" user-emacs-directory)))

;; (self/load-all)
