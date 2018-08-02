interp.load.ivy(
  "com.lihaoyi" %
  s"ammonite-shell_${scala.util.Properties.versionNumberString}" %
  ammonite.Constants.version
)
@
val shellSession = ammonite.shell.ShellSession()
import shellSession._
import ammonite.ops._
import ammonite.shell._
ammonite.shell.Configure(interp, repl, wd)
repl.prompt() = "scala>"


interp.configureCompiler(_.settings.YpartialUnification.value = true)

import $ivy.`org.typelevel::cats-core:1.1.0`, cats._, cats.data._, cats.implicits._
import $ivy.`org.typelevel::cats-effect:1.0.0-RC2`, cats.effect._

import $plugin.$ivy.`org.spire-math::kind-projector:0.9.7`

import $ivy.`org.tpolecat::doobie-core:0.5.3`, doobie._, doobie.implicits._
import $ivy.`org.tpolecat::doobie-postgres:0.5.3`

import $ivy.`co.fs2::fs2-core:1.0.0-M1`

import $ivy.`io.chrisdavenport::linebacker:0.2.0-M1`

import scala.concurrent.Future
import scala.concurrent.duration._
import scala.concurrent.ExecutionContext.Implicits.global

import _root_.io.chrisdavenport.linebacker.Linebacker
import _root_.io.chrisdavenport.linebacker.contexts.Executors

import $ivy.`org.scalatest::scalatest:3.0.1`, org.scalatest._

import $ivy.`org.typelevel::cats-mtl-core:0.3.0`, cats.mtl._, cats.mtl.implicits._
