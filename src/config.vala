/* Copyright 2015 Barry Smith
*
* This file is part of Vulcan.
*
* Vulcan is free software: you can redistribute it
* and/or modify it under the terms of the GNU General Public License as
* published by the Free Software Foundation, either version 2 of the
* License, or (at your option) any later version.
*
* Vulcan is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
* Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with Vulcan. If not, see http://www.gnu.org/licenses/.
*/

namespace Vulcan
{
	public class Config : Object
	{
		public Consts consts;
		
		public DynamicList<Property> properties;
		
		public signal void dataChanged(string name, string data);
		
		public Config(Consts consts)
		{
			this.consts = consts;
			this.properties = new DynamicList<Property>();
		}
		
		public bool contains(string name)
		{
			for (int count = 0; count < this.properties.length; count ++)
			{
				if (this.properties[count].name == name)
					return true;
			}
			
			return false;
		}
		
		public Property getPropertyObject(string name)
		{
			for (int count = 0; count < this.properties.length; count ++)
			{
				if (this.properties[count].name == name)
					return this.properties[count];
			}
			
			return new Property("null", "null", this);
		}
		
		public void addProperty(string name, string data)
		{
			this.properties.add(new Property(name, data, this));
		}
		
		public void setProperty(string name, string data)
		{
			if (this.contains(name))
			{
				this.getPropertyObject(name).data = data;
			}
			else
			{
				this.addProperty(name, data);
			}
			
			this.consts.output("Set property " + name + " to " + data);
		}
		
		public string getProperty(string name)
		{
			if (this.contains(name))
			{
				return this.getPropertyObject(name).data;
			}
			else
			{
				return "null";
			}
		}
	}
	
	public class Property : Object
	{
		private string _name;
		private string _data;
		
		public Config mother;
		
		public Property(string name, string data, Config mother)
		{
			this._name = name;
			this.mother = mother;
			
			this.data = data;
		}
		
		public string name
		{
			get
			{return this._name;}
		}
		
		public string data
		{
			get
			{return this._data;}
			set
			{
				this._data = value;
				this.mother.dataChanged(this._name, value);
			}
		}
	}
}
