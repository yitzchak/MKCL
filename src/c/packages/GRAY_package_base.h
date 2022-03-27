/* -*- mode: c  -*- */
/*
    Copyright (c) 2022, Jean-Claude Beaudoin.

    This program is under GNU LGPL, you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 3 of the License, or (at your option) any later version.

    See file '../../../Copyright' for full details.
*/


#ifdef MKCL_PACKAGE_BUILDER
#define SYMBOL_NAME(it) {				\
    (int8_t)mkcl_t_base_string, 0, FALSE, FALSE,	\
      mk_cl_Cnil,					\
      (sizeof(it)-1),					\
      (sizeof(it)-1),					\
      (it),						\
      NULL, NULL,					\
      }
#else
# define SYMBOL_NAME(it) MKCL_BASE_STRING_INIT(it)
#endif

static struct mkcl_base_string const mkcl_gray_external_symbol_names[] = {
  SYMBOL_NAME("STREAM-ADVANCE-TO-COLUMN"),
  SYMBOL_NAME("STREAM-CLEAR-INPUT"),
  SYMBOL_NAME("STREAM-CLEAR-OUTPUT"),
  SYMBOL_NAME("STREAM-FILE-POSITION"),
  SYMBOL_NAME("STREAM-FINISH-OUTPUT"),
  SYMBOL_NAME("STREAM-FORCE-OUTPUT"),
  SYMBOL_NAME("STREAM-FRESH-LINE"),
  SYMBOL_NAME("STREAM-INTERACTIVE-P"),
  SYMBOL_NAME("STREAM-LINE-COLUMN"),
  SYMBOL_NAME("STREAM-LISTEN"),
  SYMBOL_NAME("STREAM-PEEK-CHAR"),
  SYMBOL_NAME("STREAM-READ-BYTE"),
  SYMBOL_NAME("STREAM-READ-CHAR"),
  SYMBOL_NAME("STREAM-READ-CHAR-NO-HANG"),
  SYMBOL_NAME("STREAM-READ-LINE"),
  SYMBOL_NAME("STREAM-READ-SEQUENCE"),
  SYMBOL_NAME("STREAM-START-LINE-P"),
  SYMBOL_NAME("STREAM-TERPRI"),
  SYMBOL_NAME("STREAM-UNREAD-CHAR"),
  SYMBOL_NAME("STREAM-WRITE-BYTE"),
  SYMBOL_NAME("STREAM-WRITE-CHAR"),
  SYMBOL_NAME("STREAM-WRITE-SEQUENCE"),
  SYMBOL_NAME("STREAM-WRITE-STRING"),
  SYMBOL_NAME("FUNDAMENTAL-STREAM"),
  SYMBOL_NAME("FUNDAMENTAL-INPUT-STREAM"),
  SYMBOL_NAME("FUNDAMENTAL-OUTPUT-STREAM"),
  SYMBOL_NAME("FUNDAMENTAL-CHARACTER-STREAM"),
  SYMBOL_NAME("FUNDAMENTAL-BINARY-STREAM"),
  SYMBOL_NAME("FUNDAMENTAL-CHARACTER-INPUT-STREAM"),
  SYMBOL_NAME("FUNDAMENTAL-CHARACTER-OUTPUT-STREAM"),
  SYMBOL_NAME("FUNDAMENTAL-BINARY-INPUT-STREAM"),
  SYMBOL_NAME("FUNDAMENTAL-BINARY-OUTPUT-STREAM"),
};


struct mkcl_base_string const mkcl_gray_internal_symbol_names[] = {
  SYMBOL_NAME("OPEN-P"),
  SYMBOL_NAME("BUG-OR-ERROR"),
  SYMBOL_NAME("INDEX"),
  SYMBOL_NAME("REDEFINE-CL-FUNCTIONS"),
  SYMBOL_NAME("COLUMN"),
  SYMBOL_NAME("START"),
  SYMBOL_NAME("END"),
  SYMBOL_NAME("OPEN-STREAM-P__FUNDAMENTAL-STREAM"),
  SYMBOL_NAME("setf-OPEN-STREAM-P__T_FUNDAMENTAL-STREAM"),
  SYMBOL_NAME("OPEN-STREAM-P__FUNDAMENTAL-INPUT-STREAM"),
  SYMBOL_NAME("setf-OPEN-STREAM-P__T_FUNDAMENTAL-INPUT-STREAM"),
  SYMBOL_NAME("OPEN-STREAM-P__FUNDAMENTAL-OUTPUT-STREAM"),
  SYMBOL_NAME("setf-OPEN-STREAM-P__T_FUNDAMENTAL-OUTPUT-STREAM"),
  SYMBOL_NAME("OPEN-STREAM-P__FUNDAMENTAL-CHARACTER-STREAM"),
  SYMBOL_NAME("setf-OPEN-STREAM-P__T_FUNDAMENTAL-CHARACTER-STREAM"),
  SYMBOL_NAME("OPEN-STREAM-P__FUNDAMENTAL-BINARY-STREAM"),
  SYMBOL_NAME("setf-OPEN-STREAM-P__T_FUNDAMENTAL-BINARY-STREAM"),
  SYMBOL_NAME("OPEN-STREAM-P__FUNDAMENTAL-CHARACTER-INPUT-STREAM"),
  SYMBOL_NAME("setf-OPEN-STREAM-P__T_FUNDAMENTAL-CHARACTER-INPUT-STREAM"),
  SYMBOL_NAME("OPEN-STREAM-P__FUNDAMENTAL-CHARACTER-OUTPUT-STREAM"),
  SYMBOL_NAME("setf-OPEN-STREAM-P__T_FUNDAMENTAL-CHARACTER-OUTPUT-STREAM"),
  SYMBOL_NAME("OPEN-STREAM-P__FUNDAMENTAL-BINARY-INPUT-STREAM"),
  SYMBOL_NAME("setf-OPEN-STREAM-P__T_FUNDAMENTAL-BINARY-INPUT-STREAM"),
  SYMBOL_NAME("OPEN-STREAM-P__FUNDAMENTAL-BINARY-OUTPUT-STREAM"),
  SYMBOL_NAME("setf-OPEN-STREAM-P__T_FUNDAMENTAL-BINARY-OUTPUT-STREAM"),
  SYMBOL_NAME("STREAM-ADVANCE-TO-COLUMN__FUNDAMENTAL-CHARACTER-OUTPUT-STREAM_T"),
  SYMBOL_NAME("STREAM-CLEAR-INPUT__FUNDAMENTAL-CHARACTER-INPUT-STREAM"),
  SYMBOL_NAME("STREAM-CLEAR-INPUT__ANSI-STREAM"),
  SYMBOL_NAME("STREAM-CLEAR-INPUT__T"),
  SYMBOL_NAME("STREAM-CLEAR-OUTPUT__FUNDAMENTAL-OUTPUT-STREAM"),
  SYMBOL_NAME("STREAM-CLEAR-OUTPUT__ANSI-STREAM"),
  SYMBOL_NAME("STREAM-CLEAR-OUTPUT__T"),
  SYMBOL_NAME("CLOSE__FUNDAMENTAL-STREAM"),
  SYMBOL_NAME("CLOSE__ANSI-STREAM"),
  SYMBOL_NAME("CLOSE__T"),
  SYMBOL_NAME("STREAM-ELEMENT-TYPE__FUNDAMENTAL-CHARACTER-STREAM"),
  SYMBOL_NAME("STREAM-ELEMENT-TYPE__ANSI-STREAM"),
  SYMBOL_NAME("STREAM-ELEMENT-TYPE__T"),
  SYMBOL_NAME("STREAM-FINISH-OUTPUT__FUNDAMENTAL-OUTPUT-STREAM"),
  SYMBOL_NAME("STREAM-FINISH-OUTPUT__ANSI-STREAM"),
  SYMBOL_NAME("STREAM-FINISH-OUTPUT__T"),
  SYMBOL_NAME("STREAM-FORCE-OUTPUT__FUNDAMENTAL-OUTPUT-STREAM"),
  SYMBOL_NAME("STREAM-FORCE-OUTPUT__ANSI-STREAM"),
  SYMBOL_NAME("STREAM-FORCE-OUTPUT__T"),
  SYMBOL_NAME("STREAM-FRESH-LINE__FUNDAMENTAL-CHARACTER-OUTPUT-STREAM"),
  SYMBOL_NAME("STREAM-FRESH-LINE__ANSI-STREAM"),
  SYMBOL_NAME("INPUT-STREAM-P__FUNDAMENTAL-STREAM"),
  SYMBOL_NAME("INPUT-STREAM-P__FUNDAMENTAL-INPUT-STREAM"),
  SYMBOL_NAME("INPUT-STREAM-P__ANSI-STREAM"),
  SYMBOL_NAME("INPUT-STREAM-P__T"),
  SYMBOL_NAME("STREAM-INTERACTIVE-P__ANSI-STREAM"),
  SYMBOL_NAME("STREAM-INTERACTIVE-P__T"),
  SYMBOL_NAME("STREAM-LINE-COLUMN__FUNDAMENTAL-CHARACTER-OUTPUT-STREAM"),
  SYMBOL_NAME("STREAM-LISTEN__FUNDAMENTAL-CHARACTER-INPUT-STREAM"),
  SYMBOL_NAME("STREAM-LISTEN__ANSI-STREAM"),
  SYMBOL_NAME("STREAM-LISTEN__T"),
  SYMBOL_NAME("OPEN-STREAM-P__ANSI-STREAM"),
  SYMBOL_NAME("OPEN-STREAM-P__T"),
  SYMBOL_NAME("OUTPUT-STREAM-P__FUNDAMENTAL-STREAM"),
  SYMBOL_NAME("OUTPUT-STREAM-P__FUNDAMENTAL-OUTPUT-STREAM"),
  SYMBOL_NAME("OUTPUT-STREAM-P__ANSI-STREAM"),
  SYMBOL_NAME("OUTPUT-STREAM-P__T"),
  SYMBOL_NAME("STREAM-PEEK-CHAR__FUNDAMENTAL-CHARACTER-INPUT-STREAM"),
  SYMBOL_NAME("STREAM-PEEK-CHAR__ANSI-STREAM"),
  SYMBOL_NAME("STREAM-PEEK-CHAR__T"),
  SYMBOL_NAME("STREAM-READ-BYTE__ANSI-STREAM"),
  SYMBOL_NAME("STREAM-READ-BYTE__T"),
  SYMBOL_NAME("STREAM-READ-CHAR__ANSI-STREAM"),
  SYMBOL_NAME("STREAM-READ-CHAR__T"),
  SYMBOL_NAME("STREAM-UNREAD-CHAR__ANSI-STREAM_T"),
  SYMBOL_NAME("STREAM-UNREAD-CHAR__T_T"),
  SYMBOL_NAME("STREAM-READ-CHAR-NO-HANG__FUNDAMENTAL-CHARACTER-INPUT-STREAM"),
  SYMBOL_NAME("STREAM-READ-CHAR-NO-HANG__ANSI-STREAM"),
  SYMBOL_NAME("STREAM-READ-CHAR-NO-HANG__T"),
  SYMBOL_NAME("STREAM-READ-LINE__FUNDAMENTAL-CHARACTER-INPUT-STREAM"),
  SYMBOL_NAME("STREAM-READ-LINE__ANSI-STREAM"),
  SYMBOL_NAME("STREAM-READ-LINE__T"),
  SYMBOL_NAME("STREAM-READ-SEQUENCE__FUNDAMENTAL-CHARACTER-INPUT-STREAM_T"),
  SYMBOL_NAME("STREAM-READ-SEQUENCE__FUNDAMENTAL-BINARY-INPUT-STREAM_T"),
  SYMBOL_NAME("STREAM-READ-SEQUENCE__ANSI-STREAM_T"),
  SYMBOL_NAME("STREAM-READ-SEQUENCE__T_T"),
  SYMBOL_NAME("STREAM-START-LINE-P__FUNDAMENTAL-CHARACTER-OUTPUT-STREAM"),
  SYMBOL_NAME("STREAM-FILE-POSITION__ANSI-STREAM"),
  SYMBOL_NAME("STREAM-FILE-POSITION__T"),
  SYMBOL_NAME("STREAMP__STREAM"),
  SYMBOL_NAME("STREAMP__T"),
  SYMBOL_NAME("STREAM-WRITE-BYTE__ANSI-STREAM_T"),
  SYMBOL_NAME("STREAM-WRITE-BYTE__T_T"),
  SYMBOL_NAME("STREAM-WRITE-CHAR__ANSI-STREAM_T"),
  SYMBOL_NAME("STREAM-WRITE-CHAR__T_T"),
  SYMBOL_NAME("STREAM-WRITE-SEQUENCE__FUNDAMENTAL-CHARACTER-OUTPUT-STREAM_T"),
  SYMBOL_NAME("STREAM-WRITE-SEQUENCE__FUNDAMENTAL-BINARY-OUTPUT-STREAM_T"),
  SYMBOL_NAME("STREAM-WRITE-SEQUENCE__ANSI-STREAM_T"),
  SYMBOL_NAME("STREAM-WRITE-SEQUENCE__T_T"),
  SYMBOL_NAME("STREAM-WRITE-STRING__FUNDAMENTAL-CHARACTER-OUTPUT-STREAM_T"),
  SYMBOL_NAME("STREAM-WRITE-STRING__ANSI-STREAM_T"),
  SYMBOL_NAME("STREAM-WRITE-STRING__T_T"),
  SYMBOL_NAME("STREAM-TERPRI__FUNDAMENTAL-CHARACTER-OUTPUT-STREAM"),
  SYMBOL_NAME("STREAM-TERPRI__ANSI-STREAM"),
  SYMBOL_NAME("STREAM-TERPRI__T"),
};


#define internal_count MKCL_NB_ELEMS(mkcl_gray_internal_symbol_names)
#define external_count MKCL_NB_ELEMS(mkcl_gray_external_symbol_names)
#define internal_size 139
#define external_size 39

static struct mkcl_hashtable_entry internal_entries[];
static struct mkcl_hashtable_entry external_entries[];

static struct mkcl_hashtable_entry * internal_vector[];
static struct mkcl_hashtable_entry * external_vector[];

static struct mkcl_singlefloat rehash_size_factor = { mkcl_t_singlefloat, 0, 0, 0, 1.5f };
static struct mkcl_singlefloat rehash_threshold = { mkcl_t_singlefloat, 0, 0, 0, 0.75f };

static struct mkcl_hashtable internal_ht = {
  mkcl_t_hashtable, 0, mkcl_htt_package, 0, /* MKCL_HEADER2(test,lockable) */
  internal_vector, /* data */
#ifndef MKCL_PACKAGE_BUILDER
  mkcl_search_hash_package, /* search_fun */
  mkcl_hash_equal_package, /* hash_fun */
  mkcl_equality_fun_package, /* equality_fun */
#else
  NULL, /* search_fun */
  NULL, /* hash_fun */
  NULL, /* equality_fun */
#endif
  internal_count, /* entries */
  internal_size, /* size */
  (mkcl_object) &rehash_size_factor, /* rehash_size */
  (mkcl_object) &rehash_threshold, /* threshold */
  12, /* factor_of_16th */
  NULL /* free_bucket */
};

static struct mkcl_hashtable external_ht = {
  mkcl_t_hashtable, 0, mkcl_htt_package, 0, /* MKCL_HEADER2(test,lockable) */
  external_vector, /* data */
#ifndef MKCL_PACKAGE_BUILDER
  mkcl_search_hash_package, /* search_fun */
  mkcl_hash_equal_package, /* hash_fun */
  mkcl_equality_fun_package, /* equality_fun */
#else
  NULL, /* search_fun */
  NULL, /* hash_fun */
  NULL, /* equality_fun */
#endif
  external_count, /* entries */
  external_size, /* size */
  (mkcl_object) &rehash_size_factor, /* rehash_size */
  (mkcl_object) &rehash_threshold, /* threshold */
  12, /* factor_of_16th */
  NULL /* free_bucket */
};

static struct mkcl_base_string gray_package_name = SYMBOL_NAME("GRAY");

struct mkcl_package mkcl_package_gray = {
  mkcl_t_package, 0, 0, 0, /* MKCL_HEADER1(closed) */
  (mkcl_object) &gray_package_name, /* name */
  mk_cl_Cnil, /* nicknames */
  mk_cl_Cnil, /* shadowings */
  mk_cl_Cnil, /* uses */
  mk_cl_Cnil, /* usedby */
  (mkcl_object) &internal_ht, /* internal */
  (mkcl_object) &external_ht, /* external */
#ifndef MKCL_WINDOWS
  PTHREAD_MUTEX_INITIALIZER /* lock */
#endif
};