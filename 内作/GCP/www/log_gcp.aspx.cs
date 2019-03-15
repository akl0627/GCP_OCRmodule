using System;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices;

namespace WebApplication{
    public partial class CodeFile: System.Web.UI.Page{
        string logfilepath;
        protected void Page_Load(object sender, EventArgs e){
            logfilepath = Request.PhysicalApplicationPath + @"\poc_world\tools\ocr\log\ocrlog.csv";
            if(!IsPostBack){
                /*ユーザー情報取得*/
                string sn = ""; //姓
                string gn = ""; //名
                string tt = ""; //役職
                string dm = ""; //所属
                string em = ""; //メールアドレス
                string pg = "GCP";
                var directoryEntry = new DirectoryEntry();
                var directorySearcher = new DirectorySearcher(directoryEntry);
                string un = User.Identity.Name;
                un = un.Substring(un.LastIndexOf(@"\") + 1, un.Length - (un.LastIndexOf(@"\") + 1));
                directorySearcher.Filter = String.Format("(&(objectClass=user)(samAccountName={0}))", un);
                var result = directorySearcher.FindOne();
                if(result != null){
                    var entry = result.GetDirectoryEntry();
                    sn = (string)entry.Properties["sn"].Value;
                    gn = (string)entry.Properties["givenName"].Value;
                    tt = (string)entry.Properties["title"].Value;
                    if(tt == null){
                        tt = "-";
                    }
                    dm = (string)entry.Properties["department"].Value;
                    em = (string)entry.Properties["mail"].Value;
                }
                /*ログに作成記録 */
                Application.Lock();
                using (StreamWriter sw = new StreamWriter(logfilepath, true, System.Text.Encoding.GetEncoding("shift_jis"))) {
                    sw.WriteLine(DateTime.Now.ToString("yyyy/MM/dd,HH:mm:ss") + "," + Request.UserHostName + "," + User.Identity.Name + "," + sn + " " + gn + "," + tt + "," + dm + "," + em + "," + pg);
                }
                Application.UnLock();
            }
        }
    }
}