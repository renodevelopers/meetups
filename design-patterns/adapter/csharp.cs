using System;

public class Test
{
	public static void Main()
	{
		var book = new Book();
		var kindle = new EBookAdapter(new Kindle());

		TestClient(book);
		TestClient(kindle);
	}

	static void TestClient(PaperBookInterface book)
	{
		book.Open();
		book.TurnPage();
	}
}


interface PaperBookInterface
{
    void TurnPage();
    void Open();
}

interface EBookInterface
{
    void PressNext();
    void PressStart();
}

class Book : PaperBookInterface
{
    public void Open()
    {
    	Console.WriteLine("Book.Open()");
    }

    public void TurnPage()
    {
    	Console.WriteLine("Book.TurnPage()");
    }
}

class EBookAdapter : PaperBookInterface
{
    protected EBookInterface eBook;

    public EBookAdapter(EBookInterface ebook)
    {
        this.eBook = ebook;
    }

    public void Open()
    {
    	Console.WriteLine("EBookAdapter.Open() - wrapping: " + this.eBook.GetType().Name);
        this.eBook.PressStart();
    }

    public void TurnPage()
    {
    	Console.WriteLine("EBookAdapter.TurnPage() - wrapping: " + this.eBook.GetType().Name);
       	this.eBook.PressNext();
    }
}

class Kindle : EBookInterface
{
    public void PressNext()
    {
    	Console.WriteLine("Kindle.PressNext()");
    }
    public void PressStart()
    {
    	Console.WriteLine("Kindle.PressStart()");
    }
}
