
package ammonite
package $file.roles.dotfiles.files.`.ammonite`
import _root_.ammonite.interp.api.InterpBridge.{
  value => interp
}
import _root_.ammonite.interp.api.InterpBridge.value.{
  exit
}
import _root_.ammonite.interp.api.IvyConstructor.{
  ArtifactIdExt,
  GroupIdExt
}
import _root_.ammonite.runtime.tools.{
  browse,
  grep,
  time,
  tail
}
import _root_.ammonite.repl.tools.{
  desugar,
  source
}
import _root_.mainargs.{
  arg,
  main
}
import _root_.ammonite.repl.tools.Util.{
  PathRead
}
import .{
  res
}


object predef_2{
/*<script>*/val shellSession = ammonite.shell.ShellSession()
import shellSession._
import ammonite.ops._
import ammonite.shell._
/*<amm>*/val res_4 = /*</amm>*/ammonite.shell.Configure(interp, repl, wd)
/*<amm>*/val res_5 = /*</amm>*/repl.prompt() = "scala>"


// interp.configureCompiler(_.settings.YpartialUnification.value = true)

// import $ivy.`org.typelevel::cats-core:2.0.0`, cats._, cats.data._, cats.implicits._
// import $ivy.`org.typelevel::cats-free:2.0.0`, cats.free._
// import $ivy.`org.typelevel::cats-effect:2.0.0`, cats.effect._, cats.effect.concurrent._
//
// import $plugin.$ivy.`org.typelevel::kind-projector:0.10.3`
//
// import $ivy.`org.tpolecat::doobie-core:0.8.0-RC1`, doobie._, doobie.implicits._
// import $ivy.`org.tpolecat::doobie-postgres:0.8.0-RC1`
//
// import $ivy.`co.fs2::fs2-core:2.0.0`, fs2._, fs2.concurrent._
// import $ivy.`co.fs2::fs2-reactive-streams:2.0.0`, fs2.interop.reactivestreams._
//
// // import $ivy.`com.typesafe.akka::akka-discovery:2.6.4`
//
// import $ivy.{
//   `com.lihaoyi::requests:0.2.0`,
//   `com.lihaoyi::ujson:0.7.5`
// }
//
// // import $ivy.`org.atnos::eff:5.2.0`, org.atnos.eff._, org.atnos.eff.all._, org.atnos.eff.syntax.all._
// // import $ivy.`org.atnos::eff-cats-effect:5.2.0`, org.atnos.eff.addon.cats.effect._, IOEffect._
//
// // import $ivy.`io.chrisdavenport::linebacker:0.2.0-M1`
//
// // import $ivy.`eu.timepit::refined:0.9.2`, eu.timepit.refined._, eu.timepit.refined.api._, eu.timepit.refined.boolean._, eu.timepit.refined.auto._, eu.timepit.refined.types.string._, eu.timepit.refined.numeric._, eu.timepit.refined.generic._
// // import $ivy.`eu.timepit::refined-cats:0.9.2`, eu.timepit.refined.cats._
//
// import scala.concurrent.Future
// import scala.concurrent.duration._
// import scala.concurrent.ExecutionContext.Implicits.global
//
// implicit val cs: ContextShift[IO] = IO.contextShift(global)
// implicit val timer: Timer[IO] = IO.timer(global)
//
// // import _root_.io.chrisdavenport.linebacker.Linebacker
// // import _root_.io.chrisdavenport.linebacker.contexts.Executors
//
// // import $ivy.`org.scalatest::scalatest:3.0.1`, org.scalatest._
//
// // import $ivy.`com.olegpy::meow-mtl:0.2.0`, com.olegpy.meow.hierarchy._, com.olegpy.meow.effects._
// // import $ivy.`org.typelevel::cats-mtl-core:0.4.0`, _root_.cats.mtl._, _root_.cats.mtl.instances.all._
//
// import scala.util.Random._
//
// // import $ivy.`com.spinoco::fs2-kafka:0.4.0-SNAPSHOT`, spinoco.fs2.kafka, spinoco.fs2.kafka._, spinoco.protocol.kafka._, spinoco.fs2.kafka.network._
//
// // import $ivy.`com.spinoco::fs2-log-core:0.1.0`, spinoco.fs2.log._
// // import $ivy.`org.typelevel::cats-collections-core:0.7.0`, cats.collections._, cats.collections.syntax.all._
//
// import java.net.InetAddress
//
// import $ivy.`io.circe::circe-core:0.12.1`
// import $ivy.`io.circe::circe-generic:0.12.1`
// import $ivy.`io.circe::circe-parser:0.12.1`
//
// import _root_.io.circe._, _root_.io.circe.generic.auto._, _root_.io.circe.parser._, _root_.io.circe.syntax._
//
// import $ivy.`com.softwaremill.sttp::core:1.6.6`, com.softwaremill.sttp._
// import $ivy.`com.softwaremill.sttp::akka-http-backend:1.6.6`, com.softwaremill.sttp.akkahttp._
// import $ivy.`com.softwaremill.sttp::circe:1.6.6`, com.softwaremill.sttp.circe._
//
// import $ivy.`com.typesafe.akka::akka-stream:2.5.25`
// import akka.stream.scaladsl.FileIO
// import akka.stream.scaladsl.Sink
// import akka.stream.scaladsl.Source
// import akka.stream.ActorMaterializer
// import akka.actor.ActorSystem
//
// implicit val system = ActorSystem()
// system.registerOnTermination {
//   System.exit(0)
// }
//
// implicit val materializer = ActorMaterializer()
//
//
// // import $ivy.`org.apache.spark::spark-sql:2.4.0`, org.apache.spark.sql._, org.apache.spark._
// // import $ivy.`sh.almond::ammonite-spark:0.2.0`
//
// // import $ivy.`com.iheart::ficus:1.4.6`, net.ceedubs.ficus.Ficus._
//
// import $ivy.`com.typesafe.play::play-ahc-ws-standalone:2.0.7`, play.api.libs.ws._, play.api.libs.ws.ahc._
// import $ivy.`com.typesafe.play::play-ws-standalone-json:2.0.7`
/*</script>*/ /*<generated>*/
def $main() = { scala.Iterator[String]() }
  override def toString = "predef_2"
  /*</generated>*/
}
