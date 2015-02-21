import massive.munit.TestSuite;

import MapTest;
import BasicTest;
import ArrayTest;
import ObjectTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(MapTest);
		add(BasicTest);
		add(ArrayTest);
		add(ObjectTest);
	}
}
