/***** Autogenerated from runfile.in; changes will be overwritten *****/

#line 1 "runtimebase.in"
/*****
 * runtimebase.in
 * Andy Hammerlindl  2009/07/28
 *
 * Common declarations needed for all code-generating .in files.
 *
 *****/


#line 1 "runfile.in"
/*****
 * runfile.in
 *
 * Runtime functions for file operations.
 *
 *****/

#line 1 "runtimebase.in"
#include "stack.h"
#include "types.h"
#include "builtin.h"
#include "entry.h"
#include "errormsg.h"
#include "array.h"
#include "triple.h"
#include "callable.h"
#include "opsymbols.h"

using vm::stack;
using vm::error;
using vm::array;
using vm::read;
using vm::callable;
using types::formal;
using types::function;
using camp::triple;

#define PRIMITIVE(name,Name,asyName) using types::prim##Name;
#include <primitives.h>
#undef PRIMITIVE

typedef double real;

void unused(void *);

namespace run {
array *copyArray(array *a);
array *copyArray2(array *a);
array *copyArray3(array *a);

double *copyTripleArray2Components(array *a, size_t &N,
                                   GCPlacement placement=NoGC);
triple *copyTripleArray2C(array *a, size_t &N,
                          GCPlacement placement=NoGC);
}

function *realRealFunction();

#define CURRENTPEN processData().currentpen

#line 10 "runfile.in"
#include "fileio.h"
#include "callable.h"
#include "triple.h"
#include "array.h"

#ifdef __CYGWIN__
  extern "C" int mkstemp(char *c);
#endif

using namespace camp;
using namespace settings;
using namespace vm;

string commentchar="#";

// Autogenerated routines:



#ifndef NOSYM
#include "runfile.symbols.h"

#endif
namespace run {
#line 28 "runfile.in"
// bool ==(file *a, file *b);
void gen_runfile0(stack *Stack)
{
  file * b=vm::pop<file *>(Stack);
  file * a=vm::pop<file *>(Stack);
#line 29 "runfile.in"
  {Stack->push<bool>(a == b); return;}
}

#line 33 "runfile.in"
// bool !=(file *a, file *b);
void gen_runfile1(stack *Stack)
{
  file * b=vm::pop<file *>(Stack);
  file * a=vm::pop<file *>(Stack);
#line 34 "runfile.in"
  {Stack->push<bool>(a != b); return;}
}

#line 38 "runfile.in"
void nullFile(stack *Stack)
{
#line 39 "runfile.in"
  {Stack->push<file*>(&camp::nullfile); return;}
}

#line 43 "runfile.in"
// file* input(string name=emptystring, bool check=true,            string comment=commentchar, string mode=emptystring);
void gen_runfile3(stack *Stack)
{
  string mode=vm::pop<string>(Stack,emptystring);
  string comment=vm::pop<string>(Stack,commentchar);
  bool check=vm::pop<bool>(Stack,true);
  string name=vm::pop<string>(Stack,emptystring);
#line 45 "runfile.in"
  file *f=NULL;
  if(mode == "binary")
    f=new ibfile(name,check);
  else if(mode == "xdr" || mode == "xdrgz") {
#ifdef HAVE_RPC_RPC_H
    if(mode == "xdr")
      f=new ixfile(name,check);
    else if(mode == "xdrgz")
      f=new igzxfile(name,check);
#else
    ostringstream buf;
    buf << name << ": XDR read support not enabled";
    error(buf);
#endif
  } else if(mode == "") {
    char c=comment.empty() ? (char) 0 : comment[0];
    f=new camp::ifile(name,c,check);
  } else {
    f=NULL;
    ostringstream buf;
    buf << name << ": invalid file mode '" << mode << "'";
    error(buf);
  }

  f->open();
  {Stack->push<file*>(f); return;}
}

#line 74 "runfile.in"
// file* output(string name=emptystring, bool update=false,             string comment=commentchar, string mode=emptystring);
void gen_runfile4(stack *Stack)
{
  string mode=vm::pop<string>(Stack,emptystring);
  string comment=vm::pop<string>(Stack,commentchar);
  bool update=vm::pop<bool>(Stack,false);
  string name=vm::pop<string>(Stack,emptystring);
#line 76 "runfile.in"
  file *f=NULL;
  if(mode == "pipe") {
    f=new opipe(name);
  } else if(mode == "binary") {
    if(update) f=new iobfile(name);
    else f=new obfile(name);
  } else if(mode == "xdr") {
#ifdef HAVE_RPC_RPC_H
    if(update)
      f=new ioxfile(name);
    else f=new oxfile(name);
#else
    ostringstream buf;
    buf << name << ": XDR write support not enabled";
    error(buf);
#endif
  } else if(mode == "") {
    if(update) {
      char c=comment.empty() ? (char) 0 : comment[0];
      f=new iofile(name,c);
    } else f=new ofile(name);
  } else {
    f=NULL;
    ostringstream buf;
    buf << name << ": invalid file mode '" << mode << "'";
    error(buf);
  }

  f->open();
  if(update) f->seek(0,false);

  {Stack->push<file*>(f); return;}
}

#line 111 "runfile.in"
// bool eof(file *f);
void gen_runfile5(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 112 "runfile.in"
  {Stack->push<bool>(f->eof()); return;}
}

#line 116 "runfile.in"
// bool eol(file *f);
void gen_runfile6(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 117 "runfile.in"
  {Stack->push<bool>(f->eol()); return;}
}

#line 121 "runfile.in"
// bool error(file *f);
void gen_runfile7(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 122 "runfile.in"
  {Stack->push<bool>(f->error()); return;}
}

#line 126 "runfile.in"
// void clear(file *f);
void gen_runfile8(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 127 "runfile.in"
  f->clear();
}

#line 131 "runfile.in"
// void close(file *f);
void gen_runfile9(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 132 "runfile.in"
  f->close();
}

#line 136 "runfile.in"
// Int precision(file *f=NULL, Int digits=0);
void gen_runfile10(stack *Stack)
{
  Int digits=vm::pop<Int>(Stack,0);
  file * f=vm::pop<file *>(Stack,NULL);
#line 137 "runfile.in"
  if(f == 0) f=&camp::Stdout;
  {Stack->push<Int>(f->precision(digits)); return;}
}

#line 142 "runfile.in"
// void flush(file *f);
void gen_runfile11(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 143 "runfile.in"
  f->flush();
}

#line 147 "runfile.in"
// string getc(file *f);
void gen_runfile12(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 148 "runfile.in"
  char c=0;
  if(f->isOpen()) f->read(c);
  {Stack->push<string>(string(1,c)); return;}
}

#line 154 "runfile.in"
// Int tell(file *f);
void gen_runfile13(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 155 "runfile.in"
  {Stack->push<Int>(f->tell()); return;}
}

#line 159 "runfile.in"
// void seek(file *f, Int pos);
void gen_runfile14(stack *Stack)
{
  Int pos=vm::pop<Int>(Stack);
  file * f=vm::pop<file *>(Stack);
#line 160 "runfile.in"
  f->seek(pos,pos >= 0);
}

#line 164 "runfile.in"
// void seekeof(file *f);
void gen_runfile15(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 165 "runfile.in"
  f->seek(0,false);
}

#line 169 "runfile.in"
void namePart(stack *Stack)
{
  file f=vm::pop<file>(Stack);
#line 170 "runfile.in"
  {Stack->push<string>(f.filename()); return;}
}

#line 174 "runfile.in"
void modePart(stack *Stack)
{
  file f=vm::pop<file>(Stack);
#line 175 "runfile.in"
  {Stack->push<string>(f.FileMode()); return;}
}

// Set file dimensions
#line 180 "runfile.in"
void dimensionSetHelper(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
  Int nz=vm::pop<Int>(Stack,-1);
  Int ny=vm::pop<Int>(Stack,-1);
  Int nx=vm::pop<Int>(Stack,-1);
#line 181 "runfile.in"
  f->dimension(nx,ny,nz);
  {Stack->push<file*>(f); return;}
}

#line 186 "runfile.in"
void dimensionSet(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 187 "runfile.in"
  {Stack->push<callable*>(new thunk(new bfunc(dimensionSetHelper),f)); return;}
}

#line 191 "runfile.in"
void dimensionPart(stack *Stack)
{
  file f=vm::pop<file>(Stack);
#line 192 "runfile.in"
  array *a=new array(3);
  (*a)[0]=f.Nx();
  (*a)[1]=f.Ny();
  (*a)[2]=f.Nz();
  {Stack->push<array*>(a); return;}
}

// Set file f to read arrays in line-at-a-time mode
#line 201 "runfile.in"
void lineSetHelper(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
  bool b=vm::pop<bool>(Stack,true);
#line 202 "runfile.in"
  f->LineMode(b);
  {Stack->push<file*>(f); return;}
}

#line 207 "runfile.in"
void lineSet(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 208 "runfile.in"
  {Stack->push<callable*>(new thunk(new bfunc(lineSetHelper),f)); return;}
}

#line 212 "runfile.in"
void linePart(stack *Stack)
{
  file f=vm::pop<file>(Stack);
#line 213 "runfile.in"
  {Stack->push<bool>(f.LineMode()); return;}
}

// Set file to read comma-separated values
#line 218 "runfile.in"
void csvSetHelper(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
  bool b=vm::pop<bool>(Stack,true);
#line 219 "runfile.in"
  f->CSVMode(b);
  {Stack->push<file*>(f); return;}
}

#line 224 "runfile.in"
void csvSet(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 225 "runfile.in"
  {Stack->push<callable*>(new thunk(new bfunc(csvSetHelper),f)); return;}
}

#line 229 "runfile.in"
void csvPart(stack *Stack)
{
  file f=vm::pop<file>(Stack);
#line 230 "runfile.in"
  {Stack->push<bool>(f.CSVMode()); return;}
}

// Set file to read whitespace-separated values
#line 235 "runfile.in"
void wordSetHelper(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
  bool b=vm::pop<bool>(Stack,true);
#line 236 "runfile.in"
  f->WordMode(b);
  {Stack->push<file*>(f); return;}
}

#line 241 "runfile.in"
void wordSet(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 242 "runfile.in"
  {Stack->push<callable*>(new thunk(new bfunc(wordSetHelper),f)); return;}
}

#line 246 "runfile.in"
void wordPart(stack *Stack)
{
  file f=vm::pop<file>(Stack);
#line 247 "runfile.in"
  {Stack->push<bool>(f.WordMode()); return;}
}

// Set file to read/write single precision real XDR values.
#line 252 "runfile.in"
void singlerealSetHelper(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
  bool b=vm::pop<bool>(Stack,true);
#line 253 "runfile.in"
  f->SingleReal(b);
  {Stack->push<file*>(f); return;}
}

#line 258 "runfile.in"
void singlerealSet(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 259 "runfile.in"
  {Stack->push<callable*>(new thunk(new bfunc(singlerealSetHelper),f)); return;}
}

#line 263 "runfile.in"
void singlerealPart(stack *Stack)
{
  file f=vm::pop<file>(Stack);
#line 264 "runfile.in"
  {Stack->push<bool>(f.SingleReal()); return;}
}

// Set file to read/write single precision int XDR values.
#line 269 "runfile.in"
void singleintSetHelper(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
  bool b=vm::pop<bool>(Stack,true);
#line 270 "runfile.in"
  f->SingleInt(b);
  {Stack->push<file*>(f); return;}
}

#line 275 "runfile.in"
void singleintSet(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 276 "runfile.in"
  {Stack->push<callable*>(new thunk(new bfunc(singleintSetHelper),f)); return;}
}

#line 280 "runfile.in"
void singleintPart(stack *Stack)
{
  file f=vm::pop<file>(Stack);
#line 281 "runfile.in"
  {Stack->push<bool>(f.SingleInt()); return;}
}

// Set file to read/write signed int XDR values.
#line 286 "runfile.in"
void signedintSetHelper(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
  bool b=vm::pop<bool>(Stack,true);
#line 287 "runfile.in"
  f->SignedInt(b);
  {Stack->push<file*>(f); return;}
}

#line 292 "runfile.in"
void signedintSet(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 293 "runfile.in"
  {Stack->push<callable*>(new thunk(new bfunc(signedintSetHelper),f)); return;}
}

#line 297 "runfile.in"
void signedintPart(stack *Stack)
{
  file f=vm::pop<file>(Stack);
#line 298 "runfile.in"
  {Stack->push<bool>(f.SignedInt()); return;}
}

// Set file to read an arrayi (i int sizes followed by an i-dimensional array)
#line 303 "runfile.in"
void readSetHelper(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
  Int i=vm::pop<Int>(Stack);
#line 304 "runfile.in"
  switch(i) {
    case 1:
    f->dimension(-2);
    break;

    case 2:
    f->dimension(-2,-2);
    break;

    case 3:
    f->dimension(-2,-2,-2);
    break;

    default:
    f->dimension();
  }

  {Stack->push<file*>(f); return;}
}

#line 325 "runfile.in"
void readSet(stack *Stack)
{
  file * f=vm::pop<file *>(Stack);
#line 326 "runfile.in"
  {Stack->push<callable*>(new thunk(new bfunc(readSetHelper),f)); return;}
}

// Delete file named s.
#line 331 "runfile.in"
// Int delete(string s);
void gen_runfile41(stack *Stack)
{
  string s=vm::pop<string>(Stack);
#line 332 "runfile.in"
  s=outpath(s);
  Int rc=unlink(s.c_str());
  if(rc == 0 && verbose > 0)
    cout << "Deleted " << s << endl;
  {Stack->push<Int>(rc); return;}
}

// Rename file "from" to file "to".
#line 341 "runfile.in"
// Int rename(string from, string to);
void gen_runfile42(stack *Stack)
{
  string to=vm::pop<string>(Stack);
  string from=vm::pop<string>(Stack);
#line 342 "runfile.in"
  from=outpath(from);
  to=outpath(to);
  Int rc=rename(from.c_str(),to.c_str());
  if(rc == 0 && verbose > 0)
    cout << "Renamed " << from << " to " << to << endl;
  {Stack->push<Int>(rc); return;}
}

// Create a uniquely named temporary file.
#line 352 "runfile.in"
// string mktemp(string s);
void gen_runfile43(stack *Stack)
{
  string s=vm::pop<string>(Stack);
#line 353 "runfile.in"
  char *S=StrdupMalloc(s+"XXXXXX");
  int fd=mkstemp(S);
  if(fd < 0) {
    ostringstream buf;
    buf << "Could not create unique temporary filename based on " << s;
    error(buf);
  }
  string T(S);
  free(S);
  {Stack->push<string>(T); return;}
}

} // namespace run

namespace trans {

void gen_runfile_venv(venv &ve)
{
#line 28 "runfile.in"
  addFunc(ve, run::gen_runfile0, primBoolean(), SYM_EQ, formal(primFile(), SYM(a), false, false), formal(primFile(), SYM(b), false, false));
#line 33 "runfile.in"
  addFunc(ve, run::gen_runfile1, primBoolean(), SYM_NEQ, formal(primFile(), SYM(a), false, false), formal(primFile(), SYM(b), false, false));
#line 38 "runfile.in"
  REGISTER_BLTIN(run::nullFile,"nullFile");
#line 43 "runfile.in"
  addFunc(ve, run::gen_runfile3, primFile(), SYM(input), formal(primString(), SYM(name), true, false), formal(primBoolean(), SYM(check), true, false), formal(primString(), SYM(comment), true, false), formal(primString(), SYM(mode), true, false));
#line 74 "runfile.in"
  addFunc(ve, run::gen_runfile4, primFile(), SYM(output), formal(primString(), SYM(name), true, false), formal(primBoolean(), SYM(update), true, false), formal(primString(), SYM(comment), true, false), formal(primString(), SYM(mode), true, false));
#line 111 "runfile.in"
  addFunc(ve, run::gen_runfile5, primBoolean(), SYM(eof), formal(primFile(), SYM(f), false, false));
#line 116 "runfile.in"
  addFunc(ve, run::gen_runfile6, primBoolean(), SYM(eol), formal(primFile(), SYM(f), false, false));
#line 121 "runfile.in"
  addFunc(ve, run::gen_runfile7, primBoolean(), SYM(error), formal(primFile(), SYM(f), false, false));
#line 126 "runfile.in"
  addFunc(ve, run::gen_runfile8, primVoid(), SYM(clear), formal(primFile(), SYM(f), false, false));
#line 131 "runfile.in"
  addFunc(ve, run::gen_runfile9, primVoid(), SYM(close), formal(primFile(), SYM(f), false, false));
#line 136 "runfile.in"
  addFunc(ve, run::gen_runfile10, primInt(), SYM(precision), formal(primFile(), SYM(f), true, false), formal(primInt(), SYM(digits), true, false));
#line 142 "runfile.in"
  addFunc(ve, run::gen_runfile11, primVoid(), SYM(flush), formal(primFile(), SYM(f), false, false));
#line 147 "runfile.in"
  addFunc(ve, run::gen_runfile12, primString(), SYM(getc), formal(primFile(), SYM(f), false, false));
#line 154 "runfile.in"
  addFunc(ve, run::gen_runfile13, primInt(), SYM(tell), formal(primFile(), SYM(f), false, false));
#line 159 "runfile.in"
  addFunc(ve, run::gen_runfile14, primVoid(), SYM(seek), formal(primFile(), SYM(f), false, false), formal(primInt(), SYM(pos), false, false));
#line 164 "runfile.in"
  addFunc(ve, run::gen_runfile15, primVoid(), SYM(seekeof), formal(primFile(), SYM(f), false, false));
#line 169 "runfile.in"
  REGISTER_BLTIN(run::namePart,"namePart");
#line 174 "runfile.in"
  REGISTER_BLTIN(run::modePart,"modePart");
#line 179 "runfile.in"
  REGISTER_BLTIN(run::dimensionSetHelper,"dimensionSetHelper");
#line 186 "runfile.in"
  REGISTER_BLTIN(run::dimensionSet,"dimensionSet");
#line 191 "runfile.in"
  REGISTER_BLTIN(run::dimensionPart,"dimensionPart");
#line 200 "runfile.in"
  REGISTER_BLTIN(run::lineSetHelper,"lineSetHelper");
#line 207 "runfile.in"
  REGISTER_BLTIN(run::lineSet,"lineSet");
#line 212 "runfile.in"
  REGISTER_BLTIN(run::linePart,"linePart");
#line 217 "runfile.in"
  REGISTER_BLTIN(run::csvSetHelper,"csvSetHelper");
#line 224 "runfile.in"
  REGISTER_BLTIN(run::csvSet,"csvSet");
#line 229 "runfile.in"
  REGISTER_BLTIN(run::csvPart,"csvPart");
#line 234 "runfile.in"
  REGISTER_BLTIN(run::wordSetHelper,"wordSetHelper");
#line 241 "runfile.in"
  REGISTER_BLTIN(run::wordSet,"wordSet");
#line 246 "runfile.in"
  REGISTER_BLTIN(run::wordPart,"wordPart");
#line 251 "runfile.in"
  REGISTER_BLTIN(run::singlerealSetHelper,"singlerealSetHelper");
#line 258 "runfile.in"
  REGISTER_BLTIN(run::singlerealSet,"singlerealSet");
#line 263 "runfile.in"
  REGISTER_BLTIN(run::singlerealPart,"singlerealPart");
#line 268 "runfile.in"
  REGISTER_BLTIN(run::singleintSetHelper,"singleintSetHelper");
#line 275 "runfile.in"
  REGISTER_BLTIN(run::singleintSet,"singleintSet");
#line 280 "runfile.in"
  REGISTER_BLTIN(run::singleintPart,"singleintPart");
#line 285 "runfile.in"
  REGISTER_BLTIN(run::signedintSetHelper,"signedintSetHelper");
#line 292 "runfile.in"
  REGISTER_BLTIN(run::signedintSet,"signedintSet");
#line 297 "runfile.in"
  REGISTER_BLTIN(run::signedintPart,"signedintPart");
#line 302 "runfile.in"
  REGISTER_BLTIN(run::readSetHelper,"readSetHelper");
#line 325 "runfile.in"
  REGISTER_BLTIN(run::readSet,"readSet");
#line 330 "runfile.in"
  addFunc(ve, run::gen_runfile41, primInt(), SYM(delete), formal(primString(), SYM(s), false, false));
#line 340 "runfile.in"
  addFunc(ve, run::gen_runfile42, primInt(), SYM(rename), formal(primString(), SYM(from), false, false), formal(primString(), SYM(to), false, false));
#line 351 "runfile.in"
  addFunc(ve, run::gen_runfile43, primString(), SYM(mktemp), formal(primString(), SYM(s), false, false));
}

} // namespace trans
