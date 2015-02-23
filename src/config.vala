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
