using System.Web;
using System.Web.Optimization;

namespace tBOT
{
    public class BundleConfig
    {
        public static void RegisterBundles(BundleCollection bundles)
        {

            //bundles.Add(new ScriptBundle("~/bundles/angular-sanitize").Include(
            //        "~/Scripts/angular-sanitize.js"));



            //bundles.Add(new ScriptBundle("~/bundles/ui-bootstrap-tpls").Include(
            //    "~/Scripts/ui-bootstrap-tpls-2.5.0.min.js"));


            //     bundles.Add(new ScriptBundle("~/bundles/angular-animate").Include(
            //"~/Scripts/angular-animate.js"));



            bundles.Add(new ScriptBundle("~/bundles/angularjs").Include(
                    "~/Scripts/angular.js"));


            bundles.Add(new ScriptBundle("~/bundles/ui-bootstrap-tpls").Include(
                    "~/Scripts/ui-bootstrap-tpls-0.6.0.js"));

            bundles.Add(new ScriptBundle("~/bundles/ui-layout-js").Include(
                    "~/Scripts/ui-layout.js"));

            bundles.Add(new ScriptBundle("~/bundles/app").Include(
                "~/Scripts/app.js"));
            

            bundles.Add(new ScriptBundle("~/bundles/validationApp-js").Include(
                "~/Scripts/validationApp.js"));


            bundles.Add(new ScriptBundle("~/bundles/rough-js").Include(
                "~/Scripts/rough.js"));


            bundles.Add(new StyleBundle("~/Content/ui-layout").Include(
                   "~/Content/ui-layout.css"));

            bundles.Add(new StyleBundle("~/Content/bootstrap-min").Include(
                    "~/Content/bootstrap.min.css"));




        }
    }
}
