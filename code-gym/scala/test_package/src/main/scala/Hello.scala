package gym.basic
/** Provdes classes for basc scala examples
 *
 *  ==Overview==
 *  Completed Examples
 *  - While loop
 *
 */

trait Test{
  def getName:String
  def getNum:Int

  override def toString = "Test_" + getName + "(" + getNum + ")"
}

/** While Loop Test
 *
 * @constructor Create a new test
 * @param name Name of thet test
 */
class WhileTest(name: String, num: Int) extends Test{
  def getName:String = name
  def getNum:Int = num

  /** Runs a while loop */
  def run() = {
    var i = 1;
    while(i <= num) {
      println("Hello " + name +  " World " + i);
      i += 1;
    }
  }
}

/** Factory for [[gym.basic.Test]] instances. */
object TestFactory{
  def apply(testType: String, num: Int) = testType.toUpperCase match {
      case "WHILE" => new WhileTest(testType, num)
  }
}

/** Factory for [[gym.basic.Test]] instances. */
object RunBasic extends App{
  val test1 = TestFactory("WHILE", 5);
  test1.run();
}
